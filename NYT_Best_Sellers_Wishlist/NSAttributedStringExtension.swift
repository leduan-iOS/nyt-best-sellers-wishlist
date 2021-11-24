//
//  NSAttributedStringExtension.swift
//  NYT_Best_Sellers_Wishlist
//
//  Created by Leduan Hernandez on 11/24/21.
//

import Foundation

// https://www.youtube.com/watch?v=cxFi4rO11uk&ab_channel=KiloLoco  <-- source

extension NSAttributedString {
    
    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
    }
    
}
