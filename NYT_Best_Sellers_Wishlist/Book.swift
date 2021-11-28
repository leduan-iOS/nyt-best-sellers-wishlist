//
//  Book.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/21/21.
//

import Foundation

class Book: Codable, Comparable{
    
    let rank: Int
    let description: String
    let title: String
    let author: String
    let book_image: URL?
    let amazon_product_url: URL
    
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
}
