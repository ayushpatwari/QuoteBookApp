//
//  ViewModel.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 8/1/23.

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

var date = NSDate()

class ViewModel : ObservableObject {
    @Published var collections = [Collection]()
    
    @Published var quotes = [LibraryQuoteModel]()
    
    
    func addCollection(Name: String, color : String)
    {
        
        let db = Firestore.firestore()
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").addDocument(data: ["Name": Name, "Color": color])

    }
    
    
    func addQuotes(quoteSelected: String)
    {
        let db = Firestore.firestore()

            db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections")
            .document("xzIYGFSE985j7Yy0EyVr").collection("quotes").addDocument(data: ["quote_id": quoteSelected])
        
    }
    
    func getCollection()
    {
        let db = Firestore.firestore()
        
        
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").addSnapshotListener { snapshot, error in
            
            if error == nil
            {
                if let snapshot = snapshot
                {
                    DispatchQueue.main.async
                    {
                        self.collections = snapshot.documents.map { d in
                            
                            return Collection(id: d.documentID, name: d["Name"] as? String ?? "", color: d["Color"] as? String ?? "")
                        }
                    }
                }
            }
        }
    }
    
    func getAllQuotes() {
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
                                                     likes: 0, createdAt: createdAt ?? Date(), visibility: visibility ?? Bool(), color: d["color"] as? String ?? "N/A")
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
    
    func getCollectionQuotes(inputCollection: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections")
            .document(inputCollection as String).collection("quotes").addSnapshotListener { snapshot, error in
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
                                                     likes: 0, createdAt: createdAt ?? Date(), visibility: visibility ?? Bool(), color : (d["color"] as? String ?? Color("Color").toHex())!)
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
}
