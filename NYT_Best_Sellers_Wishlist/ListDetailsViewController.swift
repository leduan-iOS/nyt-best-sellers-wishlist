//
//  ListDetailsViewController.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/22/21.
//

import UIKit
import Parse

class ListDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblListName: UILabel!
    @IBOutlet weak var lblUpdated: UILabel!
    @IBOutlet weak var lblPublished: UILabel!
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    
    var store: BookStore!
    var listNameEncoded: String = ""
    var listBooks: [Book] = []
    var booksImages: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
    
        store.fetchListGenre(genre: listNameEncoded) {
            (listGenreResult) in
        
            switch listGenreResult {
            case let .success(listGenre):
                print("Successfully found \(listGenre.books.count) books.")
                
                self.lblListName.text = listGenre.list_name
                self.lblUpdated.text = listGenre.updated
                self.lblPublished.text = listGenre.published_date
                self.listBooks = listGenre.books
                
                self.detailsTableView.reloadData()
                
            case let .failure(error):
                print("Error fetching book list: \(error)")
            }
        }

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.detailsTableView.rowHeight = UITableView.automaticDimension
//        self.detailsTableView.estimatedRowHeight = 600
//        print("Hi!")
//    }
    

    @IBAction func onLogoutButton(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        // making delegate available for use
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ,let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginVC
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "listDetails", for: indexPath) as! ListDetailsTableViewCell
        
        let book = listBooks[indexPath.row]
        
        cell.rank.text = "\(book.rank)"
        cell.title.text = book.title
        cell.author.text = book.author
        
        //need these to pass data to parse and then save it back to a Book object when retrieving it from Parse
        cell.lblImageURL.text = book.book_image?.absoluteString
        cell.lblAmazonURL.text = book.amazon_product_url.absoluteString
        
        if book.description == "" {
            cell.bookDescription.text = "NO AVAILABLE DESCRIPTION"
        } else {
            cell.bookDescription.text = book.description
        }
        
        //amazon link
        let path = book.amazon_product_url.absoluteString
        let text = cell.amazonLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Amazon")
        let font = cell.amazonLink.font
        cell.amazonLink.attributedText = attributedString
        cell.amazonLink.font = font
        
        store.fetchBookImage(for: book) {
            (imageResult) in

            switch imageResult {
            case let .success(image):
                cell.bookImage.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
