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
    
    
    //        init ()
    //        {
    //            self.fetchLikedItems()
    //            self.getCollection()
    //        }
    @Published var collections = [Collection]()
    
    @Published var addedQuotes = [LibraryQuoteModel]()
    
    @Published var quotes = [LibraryQuoteModel]()
    
    @Published var likedCollection: Collection?
    
    @Published var randomCollection: Collection?
    
    @Published var collectionCount = 0
    
    
    
        func getAllQuotes() {
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
        
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            let currentCollection = db.collection("users").document(user).collection("collections").document()
            
            currentCollection.setData(["Name": Name, "Color": color]);
            
            for quote in quoteSelected
            {
                currentCollection.collection("quotes").document().setData(["quote_id": quote])
            }
        }
        
        
        
    }
    

    func getCollection()
    {
        
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").addSnapshotListener { snapshot, error in
                
                if error == nil
                {
                    if let snapshot = snapshot
                    {
                        DispatchQueue.main.async
                        {
                            self.collections = snapshot.documents.map { d in
                                
                                self.collectionCount += 1;
                                
                                return Collection(id: d.documentID, name: d["Name"] as? String ?? "", color: d["Color"] as? String ?? "")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func deleteCollection(collection: Collection)
    {
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore();
            
            db.collection("users").document(user).collection("collections").document(collection.id ?? "").delete()
        }
        
    }
    
    
    func updateCollection(collection: Collection,newName : String, newColor : String)
    {
        
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").document(collection.id ?? "").setData(["Name": newName, "Color": newColor], merge: true)
        }
        
    }
    
    func getQuotesInCollection(collection: Collection)
    {
        if let user = Auth.auth().currentUser?.uid
        {
            
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").document(collection.id ?? "").collection("quotes").addSnapshotListener
            {snapshot, error in
                
                if error == nil
                {
                    if let snapshot = snapshot
                    {
                        DispatchQueue.main.async
                        {
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
    }
    
    func getLikedCollection(completion: @escaping( (Collection) -> Void))
    {
        if let user = Auth.auth().currentUser?.uid
        {
            
            print("can get user for liked collection")
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").whereField("Name", isEqualTo: "Liked").getDocuments(completion: {QuerySnapshot, error in
                
                guard let docs = QuerySnapshot?.documents else {
                    print("x")
                    return
                    
                }
                
                for d in docs
                {
                    let data = d.data()
                    
                    completion( Collection(name: data["Name"] as? String ?? "", color: data["Color"] as? String ?? ""))
                }
                
            })
        }
    }
    
    func getUser(completion: @escaping ((Int) -> Void))
    {
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            db.collection("users").document(user).getDocument(completion: {
                (document, error) in
                if let document = document, document.exists
                {
                    completion(document.data()?["collectionCound"] as? Int ?? 5)
                }
            }
            )
        }
    }
    
    func addQuoteCollection(quote: DiscoverQuote, collection: Collection)
    {
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").document(collection.id ?? "N/A").collection("quotes").addDocument(data: ["quote_id": quote.id ?? "N/A"])
        }
    }
    
    
//    func getNumberOfCollection(completion: @escaping ((Int) -> Void))
//    {
//        if let user = Auth.auth().currentUser?.uid
//        {
//            let db = Firestore.firestore()
//            
//            db.collection("users").document(user).getDocument(completion: {(QuerySnapshot, error
//                
//            })
//        }
//    }
    
    func getRandomCollection(completion: @escaping( (Collection) -> Void))
    {
        if let user = Auth.auth().currentUser?.uid
        {
            let db = Firestore.firestore()
            
            db.collection("users").document(user).collection("collections").getDocuments(completion: {QuerySnapshot, error in
                
                guard let docs = QuerySnapshot?.documents else {return}
                
                let numOfCollection = self.collectionCount
                print(numOfCollection)
                let randInt = Int.random(in: 1..<9)
                
                var index = 0
                
                for d in docs
                {
                    index += 1
                    
                    if (index == randInt)
                    {
                        let data = d.data()
                        
                        completion( Collection(name: data["Name"] as? String ?? "", color: data["Color"] as? String ?? ""))
                    }
                    
                }
                
            })
        }
    }
}




