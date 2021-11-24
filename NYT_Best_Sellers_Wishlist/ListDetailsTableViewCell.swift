//
//  ListDetailsTableViewCell.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/23/21.
//

import UIKit

class ListDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var amazonLink: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
