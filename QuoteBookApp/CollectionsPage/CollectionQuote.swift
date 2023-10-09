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
    @DocumentID var id: String?
    var author: String
    var content: String
    var likes: Int
    var createdAt: Date
}

struct Collection: Identifiable, Decodable
{
    @DocumentID var id : String?
    var name : String
    var color : String
}
