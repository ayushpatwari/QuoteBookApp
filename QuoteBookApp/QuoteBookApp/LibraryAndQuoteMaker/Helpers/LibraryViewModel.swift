//
//  ViewModel.swift
//  QuoteBook
//
//  Created by Rithik Kumar on 7/27/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class LibraryViewModel: ObservableObject {
    
    @Published var quotes = [LibraryQuoteModel]()
    
    
    func updateData(quoteToUpdate: LibraryQuoteModel, newContent: String, newAuthor: String, newVisibility: Bool, newColor : String) {
            let db = Firestore.firestore()
            
        db.collection("quotes").document(quoteToUpdate.id).setData(["author": newAuthor, "content": newContent, "visibility": newVisibility, "color" : newColor], merge: true) { error in
            if error == nil {
                    self.getData()
                }
            }
        }
    
    func deleteQuote(quoteToDelete: LibraryQuoteModel) {
        let db = Firestore.firestore()
        
        db.collection("quotes").document(quoteToDelete.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.quotes.removeAll { quote in
                        return quote.id == quoteToDelete.id
                    }
                }
            }
            
        }
    }
    
    func addData(author: String, content: String, visibility: Bool, color : String) {
        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date()) // Firebase Timestamp based on the current date
        
        let quoteData: [String: Any] = [
            "author": author,
            "content": content,
            "createdAt": timestamp,
            "visibility": visibility,
            "color" : color
        ]
        
        db.collection("quotes").addDocument(data: quoteData)
    }

    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("quotes").addSnapshotListener { snapshot, error in
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.quotes = snapshot.documents.map { d in
                            let createdAtTimestamp = d["createdAt"] as? Timestamp
                            let createdAt = createdAtTimestamp?.dateValue()
                            let visibility = d["visibility"] as? Bool
                            return LibraryQuoteModel(id: d.documentID,
                                         author: d["author"] as? String ?? "",
                                         content: d["content"] as? String ?? "",
                                                     likes: 0, createdAt: createdAt ?? Date(), visibility: visibility ?? Bool(), color : d["color"] as? String ?? "N/A")
                        }
                    }
                }
            }
        }
    }
}
