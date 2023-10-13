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
                                
                                return Quote(id: document.documentID,
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



    func updateData(quoteToUpdate: Quote, newContent: String, newAuthor: String, newVisibility: Bool, newColor: String) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {
            // Handle the case when the user is not authenticated
            return
        }

        let db = Firestore.firestore()

        db.collection("users").document(currentUserUID).collection("quotes").document(quoteToUpdate.id).setData([
            "author": newAuthor,
            "content": newContent,
            "visibility": newVisibility,
            "color": newColor
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
                        return
                    }
                }
        }
    }

    
    func addData(author: String, content: String, visibility: Bool, color: String) {
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
            "visibility": visibility,
            "color" : color
        ]

        db.collection("users").document(currentUserUID).collection("quotes").addDocument(data: quoteData) { error in
            if let error = error {
                // Handle the error
                print("Error adding quote: \(error.localizedDescription)")
            } else {
                return
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
                                         likes: 0, createdAt: createdAt ?? Date(), visibility: visibility ?? Bool(), color: d["color"] as? String ?? "N/A")
                        }
                    }
                }
            } else {
                // Handle the error
            }
        }
    }

}
