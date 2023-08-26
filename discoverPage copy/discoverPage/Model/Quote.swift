//
//  Model.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/13/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Quote: Identifiable, Decodable {
    @DocumentID var id: String?
    let content: String
    let author: String
    var likes: Int
    let color: String
    let isQOTD: Bool?
    var timestamp: Timestamp
    
    var dateStamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: (timestamp.dateValue()))
    }
    
    
    var description: String? {
"""
"\(self.content)"
  -\(self.author)

Created by QuoteBook App
"""
    }
    
}
