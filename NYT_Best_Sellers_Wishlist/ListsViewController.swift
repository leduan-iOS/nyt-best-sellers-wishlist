//
//  ViewController.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/20/21.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var listsNamesTableView: UITableView!
    
    // used Property Injection so that no instatiation in this class is necessary, check sceneDelegate
    var store: BookStore!
    var arrListsNames: [ListName] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listsNamesTableView.dataSource = self
        listsNamesTableView.delegate = self
        
//        store.fetchListsNames()
//        store.fetchListGenre(genre: "combined-print-and-e-book-fiction")

        //trailing closure syntax
        store.fetchListsNames {
            (listsNamesResult) in
            
            switch listsNamesResult {
            case let .success(listsNames):
                print("Successfully found \(listsNames.count) names.")
                self.arrListsNames = listsNames
            case let .failure(error):
                print("Error fetching lists names: \(error)")
            }
            self.listsNamesTableView.reloadData()
        }
        
      
    }// ------------------------------> viewDidLoad()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listsNamesTableView.dequeueReusableCell(withIdentifier: "listName", for: indexPath) as! ListNameTableViewCell
        let listName = arrListsNames[indexPath.row].list_name
        cell.lblListName.text = listName
        return cell
    }
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        // IMPORTANT: sender is the cell that is tapped on (if segue was set up to be the cell)
        
        // 1. Find the selected list
        
        let cell = sender as! UITableViewCell
        let indexPath = listsNamesTableView.indexPath(for: cell)!    // the tableView knows the indexPath for a given cell
        let listNameEncoded = arrListsNames[indexPath.row].list_name_encoded
        
        
        // 2. Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        let listDetailsVC = segue.destination as! ListDetailsViewController     // listDetailsVC viewDidLoad() takes place here
        listDetailsVC.listNameEncoded = listNameEncoded
        listDetailsVC.store = self.store
        
        listsNamesTableView.deselectRow(at: indexPath, animated: true)
  
    }
      
}



//store.fetchListGenre(genre: listNameEncoded) {
//    (listGenreResult) in
//
//    switch listGenreResult {
//    case let .success(listGenre):
//        print("Successfully found \(listGenre.books.count) books.")
//    case let .failure(error):
//        print("Error fetching book list: \(error)")
//    }
//}


//    func updateImageView(for book: Book) {
//        store.fetchBookImage(for: book) {
//            (imageResult) in
//
//            switch imageResult {
//            case let .success(image):
//                self.imageView?.image = image     // here, instead of updating imageView, save image into a UIImage array
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }

//        for book in listBooks {
//
//            store.fetchBookImage(for: book) {
//                (imageResult) in
//
//                switch imageResult {
//                case let .success(image):
//                    self.booksImages.append(image)
//                case let .failure(error):
//                    print("Error downloading image: \(error)")
//                }
//            }
//
//        }
