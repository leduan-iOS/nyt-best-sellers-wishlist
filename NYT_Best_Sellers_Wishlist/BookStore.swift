//
//  BookStore.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/20/21.
//

import UIKit

// URLRequest               -> request to the server uses this class
// URLSession               -> acts as a factory to URLSessionTask
// URLSessionTask, the class that communicates with the web service is an instance of URLSessionTask
// tasks: data tasks, download tasks, upload tasks
// URLSessionDataTask       -> retrieves data and returns it as 'Data' in memory
// URLSessionDownloadTask   -> returns a file saved to the filesystem
// URLSessionUploadTask     -> sends data to server

// error type to represent image errors
enum BookImageError: Error {
    case imageCreationError
    case missingImageURL
}

class BookStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    // IMPORTANT: BookStore asynchronous methods were updated to call their completion handlers on the main thread, so that info is retrieved before loading it
    // OperationQueue class was used for this
    
    // ---------------------------------------------- > "lists/names.json"
    func fetchListsNames(completion: @escaping (Result<[ListName], Error>) -> Void) {   // completion closure that will be called once the web service request is completed
        
        let url = NytAPI.listsNamesURL()
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
//            if let jsonData = data {
//                if let jsonString = String(data: jsonData, encoding: .utf8) {
//                    print(jsonString)
//                }
//            } else if let requestError = error {
//                print("Error fetching interesting photos: \(requestError)")
//            } else {
//                print("Unexpected error with the request")
//            }
            
            let result = self.processListsNamesRequest(data: data, error: error)
//            completion(result)
            OperationQueue.main.addOperation {
                completion(result)
            }
            
        }
        task.resume()
    }
    
    
    private func processListsNamesRequest(data: Data?, error: Error?) -> Result<[ListName], Error> {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return NytAPI.listsNames(fromJSON: jsonData)
    }
    
    
    // ---------------------------------------------- > "lists/current/\(genre).json"
    func fetchListGenre(genre: String, completion: @escaping (Result<ListGenreResults, Error>) -> Void) {
        
        let url = NytAPI.listGenreURL(genre: genre)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processListGenre(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    
    private func processListGenre(data: Data?, error: Error?) -> Result<ListGenreResults, Error> {
        
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return NytAPI.listGenre(fromJSON: jsonData)
    }
    
    
    // ---------------------------------------------- > processing image data (passes Book with img url to get UIImage)
    // download image data
    func fetchBookImage(for book: Book, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let imageURL = book.book_image else {
            completion(.failure(BookImageError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // parameter changed to take a image URL
    func fetchBookImage(withURL url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let imageURL = url else {
            completion(.failure(BookImageError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: imageURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    // process image request data
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                //couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(BookImageError.imageCreationError)
                }
            }
        
        return .success(image)
    }
    
    
}
