//
//  Model.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/13/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI


struct LibraryQuoteModel: Identifiable, Decodable {
    var id: String
    var author: String
    var content: String
    var likes: Int
    var createdAt : Date
    var visibility : Bool
    var color : String
    
}
