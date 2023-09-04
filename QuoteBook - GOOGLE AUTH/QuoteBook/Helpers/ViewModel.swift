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
    @Published var totalQuotesCount = 0

    
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
                                
                                return Quote(id: document.documentID,
                                             author: author,
                                             content: content, likes: 0,
                                             createdAt: createdAtTimestamp?.dateValue() ?? Date(),
                                             visibility: visibility)
                            }
                        }
                    }
                }
        }
    }



    func updateData(quoteToUpdate: Quote, newContent: String, newAuthor: String, newVisibility: Bool) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // Handle the case when the user is not authenticated
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(currentUserUID).collection("quotes").document(quoteToUpdate.id).setData([
            "author": newAuthor,
            "content": newContent,
            "visibility": newVisibility
        ], merge: true) { error in
            if error == nil {
                self.getDataForCurrentUser() // Refresh the data for the current user
            } else {
                // Handle the error
            }
        }
    }
    
    func deleteQuote(quoteToDelete: Quote) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()

            db.collection("users")
                .document(currentUserUID)
                .collection("quotes")
                .document(quoteToDelete.id).delete { error in
                    if let error = error {
                        // Handle the error
                        print("Error deleting quote: \(error.localizedDescription)")
                    } else {
                        // Successfully deleted the quote, decrement the totalQuotes count
                        self.updateTotalQuotesCount(forUserUID: currentUserUID, newCount: self.quotes.count - 1)
                    }
                }
        }
    }

    
    func addData(author: String, content: String, visibility: Bool) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // Handle the case when the user is not authenticated
            return
        }

        let db = Firestore.firestore()
        let timestamp = Timestamp(date: Date()) // Firebase Timestamp based on the current date

        let quoteData: [String: Any] = [
            "author": author,
            "content": content,
            "createdAt": timestamp,
            "visibility": visibility
        ]

        db.collection("users").document(currentUserUID).collection("quotes").addDocument(data: quoteData) { error in
            if let error = error {
                // Handle the error
                print("Error adding quote: \(error.localizedDescription)")
            } else {
                // Successfully added the quote, increment the totalQuotes count
                self.updateTotalQuotesCount(forUserUID: currentUserUID, newCount: self.quotes.count + 1)
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
                            let visibility = d["visibility"] as? Bool
                            return Quote(id: d.documentID,
                                         author: d["author"] as? String ?? "",
                                         content: d["content"] as? String ?? "",
                                         likes: 0, createdAt: createdAt ?? Date(), visibility: visibility ?? Bool())
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }
    
    func updateLifeQuote(newLifeQuote: String) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            
            // Update the lifeQuote field in the "userInfo" collection for the current user
            db.collection("users")
                .document(currentUserUID)
                .collection("userInfo")
                .document("userInfo") // You can use a specific document ID for userInfo if needed
                .setData(["lifeQuote": newLifeQuote], merge: true) { error in
                    if error == nil {
                        // Successfully updated the lifeQuote
                    } else {
                        // Handle the error
                    }
                }
        }
    }
    
    func fetchLifeQuote(completion: @escaping (String) -> Void) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            
            // Fetch the lifeQuote field in the "userInfo" collection for the current user
            db.collection("users")
                .document(currentUserUID)
                .collection("userInfo")
                .document("userInfo") // You can use a specific document ID for userInfo if needed
                .getDocument { document, error in
                    if let error = error {
                        // Handle the error
                        print("Error fetching lifeQuote: \(error.localizedDescription)")
                        completion("") // Return an empty string in case of an error
                    } else if let document = document, let lifeQuote = document.data()?["lifeQuote"] as? String {
                        // Successfully fetched the lifeQuote
                        completion(lifeQuote)
                    } else {
                        // No lifeQuote found
                        completion("")
                    }
                }
        }
    }

    func updateTotalQuotesCount(forUserUID userUID: String, newCount: Int) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .collection("userInfo")
            .document("userInfo")
            .setData(["totalQuotes": newCount], merge: true) { error in
                if let error = error {
                    // Handle the error
                    print("Error updating totalQuotes count: \(error.localizedDescription)")
                }
            }
    }

    
    func fetchTotalQuotesCount(forUserUID userUID: String, completion: @escaping (Int) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .collection("userInfo")
            .document("userInfo")
            .getDocument { document, error in
                if let error = error {
                    // Handle the error
                    print("Error fetching totalQuotes count: \(error.localizedDescription)")
                    completion(0) // Return 0 in case of an error
                } else if let document = document, let totalQuotes = document.data()?["totalQuotes"] as? Int {
                    // Successfully fetched the totalQuotes count
                    completion(totalQuotes)
                } else {
                    // No totalQuotes count found, return 0
                    completion(0)
                }
            }
    }

}
