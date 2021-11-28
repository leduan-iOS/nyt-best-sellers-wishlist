//
//  ListName.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/21/21.
//

import Foundation

class ListName: Codable, Comparable{
    
    let list_name: String
    let list_name_encoded: String
    
    static func < (lhs: ListName, rhs: ListName) -> Bool {
        return lhs.list_name < rhs.list_name
    }
    
    static func == (lhs: ListName, rhs: ListName) -> Bool {
        return lhs.list_name == rhs.list_name
    }
}
