//
//  QuoteViewModel.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Foundation
var date = NSDate()

final class QuoteViewModel: ObservableObject {
    let service = QuoteService()
    @Published var quotes = [Quote]()
    @Published var searchText: String = ""
    
    var searchedQuotes: [Quote] {
        if searchText.isEmpty {
            return quotes
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
        fetchInitialQuotes()
    }
    
    func fetchInitialQuotes () -> Void{
        service.fetchInitialQuotes{ quotes in
            self.quotes = quotes
        }
    }
    
    func likeQuote (quote: Quote) {
        service.likeQuote(quote: quote)
    }
    
    func filterQuote(withTag tag: String) {
        return
    }

}
