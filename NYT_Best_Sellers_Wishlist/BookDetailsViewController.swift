//
//  BookDetailsViewController.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/25/21.
//

import UIKit
import Parse

class BookDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bookDetailsTableView: UITableView!
    @IBOutlet weak var lblBookTitle: UILabel!
    
    var store: BookStore!
    
    var bookTitle: String = ""
    var bookAuthor: String = ""
    var bookDescription: String = ""
    var bookImageURL = ""
    var bookAmazonURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = BookStore()

        bookDetailsTableView.delegate = self
        bookDetailsTableView.dataSource = self
        
        lblBookTitle.text = bookTitle
        
        bookDetailsTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookDetailsTableView.dequeueReusableCell(withIdentifier: "bookDetails", for: indexPath) as! BookDetailsTableViewCell
        
        cell.lblAuthor.text = bookAuthor
        cell.lblDescription.text = bookDescription
        cell.bookTitle.text = bookTitle // for fetching the title in the unlist button in the cell
        
        let url = URL(string: bookImageURL)
        
        store.fetchBookImage(withURL: url) {
            (imageResult) in

            switch imageResult {
            case let .success(image):
                cell.bookImage.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
        
        //amazon link
        let path = bookAmazonURL
        let text = cell.amazonLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Amazon")
        let font = cell.amazonLink.font
        cell.amazonLink.attributedText = attributedString
        cell.amazonLink.font = font
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 720
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
