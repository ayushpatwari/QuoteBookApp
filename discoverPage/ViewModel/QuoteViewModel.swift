//
//  QuoteViewModel.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Foundation
import Firebase
import FirebaseFirestore

final class QuoteViewModel: ObservableObject {
    let service = QuoteService()
    @Published var quotes = [Quote]()
    @Published var quotes2 = [Quote]()
    @Published var searchText: String = ""
    @Published var searchable: Bool = false
    let db = Firestore.firestore().collection("users")
    
    
    //Because of the algorithm for finding best quotes, searching will not work :c.
    var searchedQuotes: [Quote] {
        if searchText.isEmpty {
            return quotes2
        } else {
            print(searchText)
            let lowercaseQuery = searchText.lowercased()
            print(quotes.filter({
                $0.author.lowercased().contains(lowercaseQuery)
            }))
            return quotes.filter({
                $0.author.lowercased().contains(lowercaseQuery)
            })
        }
        
        
    }
    
    init() {
        fetchInitialQuotes(date: Date())
    }
    
    func fetchInitialQuotes (date: Date) -> Void{
        service.fetchInitialQuotes{ quotes in
            self.quotes = quotes
            self.quotes2 = quotes.filter({
                $0.dateStamp == dateOf(with: date)
            })
            if self.quotes2.count <= 3 {
                let dayBefore = findDayBefore(date: date)
                self.fetchInitialQuotes(date: dayBefore)
            } else {
                print("Found a day with more than 3 quotes (Hooray!)")
            }
        }
    }
    
    func likeQuote (quote: Quote) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            //check if the quote provided is located in the collection known as likedQuotes
            let documentRef = db.document(currentUserUID).collection("collections").document("liked").collection("quotes").document(quote.id!)
            documentRef.getDocument { (document, error) in
                if let error = error {
                    print("Error fetching document: \(error)")
                } else if let document = document, document.exists {
                    let documentData = document.data()
                    print("DEBUG: The user has already liked the quote; should be rendered as pink: Wants to UNLIKE so will deal with that now")
                    self.service.unlikeQuote(quote: quote)
                    documentRef.delete {error in
                        if let error = error {
                            print("Error deleting quote: \(error.localizedDescription)")
                        } else {
                            return
                        }
                    }
                } else {
                    print("DEBUG: User has NOT liked the quote - about to like it now!")
                    self.service.likeQuote(quote: quote)
                    let data: [String: Any] = [
                        "id" : quote.id!
                    ]
                    documentRef.setData(data) {error in
                        if let error = error {
                            print("DEBUG: The user liked the quote but we cannot add it to their liked collection")
                        } else {
                            print("DEBUG: User has liked and Firebase is reflective of this change")
                        }
                        
                    }
                }
            }
            
        } else {
            return
        }
    }
    
    func checkIfUserLiked(quote: Quote, completionHandler: @escaping (Bool) -> Void) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            // Check if the quote provided is located in the collection known as likedQuotes
            let documentRef = db.document(currentUserUID).collection("collections").document("liked").collection("quotes").document(quote.id!)
            documentRef.getDocument { (document, error) in
                if let error = error {
                    print("Error fetching document: \(error)")
                    completionHandler(false)
                } else if let document = document, document.exists {
                    print("DEBUG: The user has already liked the quote; should be rendered as pink")
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        } else {
            completionHandler(false)
        }
    }
    
    func filterQuote(withTag tag: String) {
        return
    }

}
