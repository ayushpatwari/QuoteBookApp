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


struct Quote: Identifiable, Decodable {
    @DocumentID var id: String?
    let content: String
    let author: String
    var likes: Int
    var color: String
    let isQOTD: Bool?
    let visibility: Bool?
    var createdAt: Timestamp?
    
    var dateStamp: String {
        return dateOf(with: self.createdAt!.dateValue())
    }
    
    
    var gradCol: Color? {
        return Color.randomGradientColor(hex: self.color, deviation: 0.9)!
        
    }
    var description: String? {
"""
"\(self.content)"
  -\(self.author)

Created by QuoteBook App
"""
    }
    
}
