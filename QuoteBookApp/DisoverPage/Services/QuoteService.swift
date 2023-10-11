//
//  QuoteService.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import Foundation
import FirebaseCore

struct QuoteService {
    func fetchInitialQuotes(completion: @escaping([DiscoverQuote]) -> Void) {
        let collectionRef = Firestore.firestore().collection("quotes")
        collectionRef.order(by: "likes", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let quotes = documents.compactMap({ try? $0.data(as: DiscoverQuote.self) })
            completion(quotes)
        }
        //initially, you just get the most liked quotes. Once we get timestamp and I get Rithik's service, I can make this much better
    }
    
    func likeQuote(quote: DiscoverQuote) {
        Firestore.firestore().collection("quotes").document(quote.id ?? "")
            .updateData(["likes": quote.likes + 1])
        //change once we get Auth done
    }
    
}
