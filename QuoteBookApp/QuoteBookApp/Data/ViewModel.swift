//
//  ViewModel.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 8/1/23.

import Foundation
import Firebase
import FirebaseFirestore

class ViewModel : ObservableObject {
    @Published var collections = [Collection]()
    
    @Published var quotes = [Quote]()
    
    
    func addCollection(inputName: String, color: String)
    {
        
        
        let db = Firestore.firestore()
        
        db.collection("users").document("PXdGBOEYXMBkIMhY25ot").collection("collections").addDocument(data: ["Name": inputName, "Color": color])
    }
    
    
    func selectQuotes(quotesSelected : [String])
    {
        let db = Firestore.firestore()
        
        for quote in quotesSelected
        {
            db.collection("Users").document("PXdGBOEYXMBkIMhY25ot").collection("collections")
                .document("xzIYGFSE985j7Yy0EyVr").collection("quotes").addDocument(data: ["quote_id": quote])
        }
        
    }
    
    func getCollection()
    {
        let db = Firestore.firestore()
        
        
        
        db.collection("user").document("PXdGBOEYXMBkIMhY25ot").collection("collections").addSnapshotListener { snapshot, error in
            
            if error == nil
            {
                if let snapshot = snapshot
                {
                    DispatchQueue.main.async
                    {
                        self.collections = snapshot.documents.map { d in
                            
                            return Collection(id: d.documentID, name: d["Name"] as! String, color: d["Color"] as! String)
                        }
                    }
                }
            }
        }
    }
    
    func getQuotes()
    {
        let db = Firestore.firestore()
        
        db.collection("quotes").addSnapshotListener { snapshot, error in
            if error == nil {
                // No errors
                
                if let snapshot = snapshot
                {
                    DispatchQueue.main.async
                    {
                        self.quotes = snapshot.documents.map
                        { d in
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
