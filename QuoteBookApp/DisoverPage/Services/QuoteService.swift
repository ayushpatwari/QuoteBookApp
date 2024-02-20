//
//  QuoteService.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Firebase
import Foundation

struct QuoteService {
    func fetchInitialQuotes(completion: @escaping([DiscoverQuote]) -> Void) {
        let collectionRef = Firestore.firestore().collection("quotes")
        collectionRef.order(by: "likes", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let quotes = documents.compactMap({ try? $0.data(as: DiscoverQuote.self) })
            completion(quotes)
        }
    }
    
    func likeQuote(quote: DiscoverQuote) {
        Firestore.firestore().collection("quotes").document(quote.id ?? "")
            .updateData(["likes": quote.likes + 1])

    }
    
    func unlikeQuote(quote: DiscoverQuote) {
        Firestore.firestore().collection("quotes").document(quote.id ?? "")
            .updateData(["likes": quote.likes - 1])
      
    }

    
}
