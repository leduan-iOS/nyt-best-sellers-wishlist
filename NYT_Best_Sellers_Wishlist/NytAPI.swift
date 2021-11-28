//
//  NytAPI.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/20/21.
//

import Foundation

// type (struct) which
// will be responsible for knowing and handling all nytbooksAPI-related information. This
// includes knowing how to generate the URLs that the nyt API expects as well as
// knowing the format of the incoming JSON and how to parse that JSON into the relevant
// model objects.

struct NytAPI {
    
    // ---------------------------------------------- > Generic URL building (variables and methods)
    
    // type-level properties and methods are declared with static keyword for structs
    private static let baseURLString = "https://api.nytimes.com/svc/books/v3/"
    private static let apiKey = "rvW098dzN3kKgtprfWf9Ke7QUwTGAjvz"
    
    private static func nytURL(endPoint: String, parameters: [String:String]?) -> URL {
                
        var components = URLComponents(string: baseURLString + endPoint)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "api-key": apiKey
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.url!
    }
    
    
    // endpoint related stuff
    // 'Result' is an enum defined within the Swift standard library that is useful for encapsulating the result
    // of an operation that might succeed or fail
    // ---------------------------------------------- > "lists/names.json"
    static func listsNamesURL() -> URL {
        return nytURL(endPoint: "lists/names.json", parameters: nil)
    }
    
    static func listsNames(fromJSON data: Data) -> Result<[ListName], Error> {
        
        do {
            let decoder = JSONDecoder()
            let listsNamesResponse = try decoder.decode(ListsNamesResponse.self, from: data)
            return .success(listsNamesResponse.results)
        } catch {
            return .failure(error)
        }
    }
    
    
    // ---------------------------------------------- > "lists/current/\(genre).json"
    static func listGenreURL(genre: String) -> URL {
        return nytURL(endPoint: "lists/current/\(genre).json", parameters: nil)
    }
    
    static func listGenre(fromJSON data: Data) -> Result<ListGenreResults, Error> {     // return list info
        
        do {
            let decoder = JSONDecoder()
            let listGenreResponse = try decoder.decode(ListGenreResponse.self, from: data)
            return .success(listGenreResponse.results)
        } catch {
            return .failure(error)
        }
    }
    
    static func listGenreBooks(fromJSON data: Data) -> Result<[Book], Error> {          // return books info
        
        do {
            let decoder = JSONDecoder()
            let listGenreResponse = try decoder.decode(ListGenreResponse.self, from: data)
            return .success(listGenreResponse.results.books)
        } catch {
            return .failure(error)
        }
    }

    
}

// MODELS for decoding the json into

// ---------------------------------------------- > "lists/names.json"
struct ListsNamesResponse: Codable {
    
    let results: [ListName]     // see ListName.swift
}


// ---------------------------------------------- > "lists/current/\(genre).json"
// as a note, each struct below is representing a dictionary within the json
struct ListGenreResponse: Codable {
    
    let results: ListGenreResults   // in the json returned, results is a dictionary
}

struct ListGenreResults: Codable {
    
    let list_name: String
    let published_date: String
    let updated: String
    let books: [Book]           // see Book.swift
}

