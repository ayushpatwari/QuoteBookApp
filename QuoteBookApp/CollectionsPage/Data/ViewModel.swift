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
    
    
    func getDataForCurrentUser() {
            if let currentUserUID = Auth.auth().currentUser?.uid {
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(currentUserUID)
                    .collection("quotes")
                    .order(by: "createdAt", descending: true) // You can adjust the sorting as needed
                    .addSnapshotListener { snapshot, error in
                        if let error = error {
                            // Handle the error
                            print("Error fetching data: \(error.localizedDescription)")
                            return
                        }
                        
                        if let snapshot = snapshot {
                            DispatchQueue.main.async {
                                self.quotes = snapshot.documents.compactMap { document in
                                    let data = document.data()
                                    let author = data["author"] as? String ?? ""
                                    let content = data["content"] as? String ?? ""
                                    let createdAtTimestamp = data["createdAt"] as? Timestamp
                                    let visibility = data["visibility"] as? Bool ?? false
                                    let color = data["color"] as? String ?? "N/A"
                                    
                                    return LibraryQuoteModel(id: document.documentID,
                                                 author: author,
                                                 content: content, likes: 0,
                                                 createdAt: createdAtTimestamp?.dateValue() ?? Date(),
                                                 visibility: visibility, color: color)
                                }
                            }
                        }
                    }
            }
        }
    
    
    func addCollection(Name: String, color : String, quoteSelected: [String])
    {
        
        let db = Firestore.firestore()
        
        let currentCollection = db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").document()
        
        currentCollection.setData(["Name": Name, "Color": color]);
        
        for quote in quoteSelected
        {
            currentCollection.collection("quotes").document().setData(["quote_id": quote])
        }

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
    
    func deleteCollection(collection: Collection)
    {
        let db = Firestore.firestore();
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").document(collection.id ?? "").delete()
    }
    
    
    func updateCollection(collection: Collection,newName : String, newColor : String)
    {
        let db = Firestore.firestore()
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").document(collection.id ?? "").setData(["Name": newName, "Color": newColor], merge: true)
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
