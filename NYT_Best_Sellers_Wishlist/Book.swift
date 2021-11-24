//
//  Book.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/21/21.
//

import Foundation

class Book: Codable{
    let rank: Int
    let description: String
    let title: String
    let author: String
    let book_image: URL?
    let amazon_product_url: URL
}
