//
//  Quote.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 8/1/23.
//


import Foundation

struct Quote: Identifiable 
{
    var id: String
    var author: String
    var content: String
    var likes: Int
    var createdAt: Date
}

struct Collection: Identifiable 
{
    let id: String
    let name: String
    let color: String
}
//
//extension Collection {
//    static let all: [Collection] = [
//        Collection (
//            id: "ID",
//            name: "Motivation",
//            color:"red"
//        )
//    ]
//}
//

