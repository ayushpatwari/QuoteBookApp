//
//  Collections_Info.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/18/23.
//

import Foundation


struct Collection: Identifiable {
    let id = UUID()
    let name: String
    let quotes: [String]
    
}


extension Collection {
    static let all: [Collection] = [
        Collection (
            name: "Motivation",
            quotes: ["Car", "Hero"]
        ),
        Collection (name: "Happy", quotes: ["Yay", "W"])
    ]
}
