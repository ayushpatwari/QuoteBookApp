//
//  Quote.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 7/27/23.
//

import Foundation


struct Quote: Identifiable {
    var id: String
    var author: String
    var content: String
    var likes: Int
    var createdAt: Date
    var visibility: Bool
}
