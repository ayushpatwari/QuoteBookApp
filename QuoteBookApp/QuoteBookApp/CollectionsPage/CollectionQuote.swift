//
//  Quote.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 8/1/23.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct CollectionQuote: Identifiable
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
    let color : String
}
