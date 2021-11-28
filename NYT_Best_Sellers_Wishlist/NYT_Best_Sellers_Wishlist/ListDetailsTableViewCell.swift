//
//  ListDetailsTableViewCell.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/23/21.
//

import UIKit
import Parse

class ListDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var amazonLink: UITextView!
    
    @IBOutlet weak var lblImageURL: UILabel!
    @IBOutlet weak var lblAmazonURL: UILabel!
    
    @IBOutlet weak var lblPrompt: UILabel!
    
    
    @IBAction func onWishlist(_ sender: Any) {
        
        let bookTitle = title.text!
        let nytUser = PFUser.current()!
        let query = PFQuery(className: "Books")
        query.whereKey("title", equalTo: bookTitle)
        query.whereKey("nytUser", equalTo: nytUser)
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) in
            
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
                
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) books.")
                // Do something with the found objects

                // if count > 0 then let user know book is already in the wishlist
                if objects.count > 0 {
                    self.lblPrompt.textColor = UIColor.systemRed
                    self.lblPrompt.text = "* already added to Wishlist"
                    return
                }
                
                // if count = 0 then proceed to add the book
                
                let book = PFObject(className: "Books")
                
                book["rank"] = Int(self.rank.text!)
                book["description"] = self.bookDescription.text
                book["title"] = self.title.text
                book["author"] = self.author.text
                book["book_image"] = self.lblImageURL.text
                book["amazon_product_url"] = self.lblAmazonURL.text
                book["nytUser"] = nytUser
                
                
                book.saveInBackground { (succeeded, error)  in
                    if (succeeded) {
                        // The object has been saved.
                        print("Book was saved to Parse")
                        self.lblPrompt.textColor = UIColor.systemBlue
                        self.lblPrompt.text = "* added to Wishlist"
                    } else {
                        // There was a problem, check error.description
                        print("Error saving book to Parse")
                    }
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//        let book = PFObject(className: "Books")
//
//        book["rank"] = Int(rank.text!)
//        book["description"] = bookDescription.text
//        book["title"] = title.text
//        book["author"] = author.text
//        book["book_image"] = lblImageURL.text
//        book["amazon_product_url"] = lblAmazonURL.text
//        book["nytUser"] = PFUser.current()!
//
//
//        book.saveInBackground { (succeeded, error)  in
//            if (succeeded) {
//                // The object has been saved.
//                print("Book was saved to Parse")
//                self.lblPrompt.textColor = UIColor.systemBlue
//                self.lblPrompt.text = "* added to Wishlist"
//            } else {
//                // There was a problem, check error.description
//                print("Error saving book to Parse")
//            }
//        }
