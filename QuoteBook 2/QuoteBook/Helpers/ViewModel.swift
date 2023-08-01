//
//  ViewModel.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 7/27/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class ViewModel: ObservableObject {
    
    @Published var quotes = [Quote]()
    
    
    func updateData(quoteToUpdate: Quote, newContent: String, newAuthor: String) {
            let db = Firestore.firestore()
            
            db.collection("quotes").document(quoteToUpdate.id).setData(["author": newAuthor, "content": newContent], merge: true) { error in
                if error == nil {
                    self.getData()
                }
            }
        }
    
    func deleteQuote(quoteToDelete: Quote) {
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
    
    func addData(author: String, content: String) {
        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date()) // Firebase Timestamp based on the current date
        
        let quoteData: [String: Any] = [
            "author": author,
            "content": content,
            "createdAt": timestamp // Set the Firebase Timestamp for createdAt field
        ]
        
        db.collection("quotes").addDocument(data: quoteData) { error in
            if error == nil {
                // No errors
                self.getData()
            } else {
                // Handle the error
            }
        }
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
                            return Quote(id: d.documentID,
                                         author: d["author"] as? String ?? "",
                                         content: d["content"] as? String ?? "",
                                         likes: 0, createdAt: createdAt ?? Date())
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
}
