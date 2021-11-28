//
//  BookDetailsTableViewCell.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/26/21.
//

import UIKit
import Parse

class BookDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var amazonLink: UITextView!
    @IBOutlet weak var bookTitle: UILabel!
    
    @IBOutlet weak var lblPrompt: UILabel!
    
    @IBAction func onUnlist(_ sender: Any) {
        
        let title = bookTitle.text!
        let nytUser = PFUser.current()!
        let query = PFQuery(className: "Books")
        query.whereKey("title", equalTo: title)
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
                for object in objects {
//                    print(object.objectId as Any)
                    object.deleteInBackground()
                }
                self.lblPrompt.text = "* removed from Wishlist"
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
