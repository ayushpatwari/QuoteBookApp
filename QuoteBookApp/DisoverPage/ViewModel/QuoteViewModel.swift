//
//  QuoteViewModel.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Foundation

final class QuoteViewModel: ObservableObject {
    let service = QuoteService()
    @Published var quotes = [DiscoverQuote]()
    var quotes2 = [DiscoverQuote]()
    @Published var searchText: String = ""
    
    
    //Because of the algorithm for finding best quotes, searching will not work :c.
    var searchedQuotes: [DiscoverQuote] {
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
        fetchInitialQuotes()    }
    
    func fetchInitialQuotes () -> Void{
        service.fetchInitialQuotes{ quotes in
            self.quotes2 = quotes.filter({
                $0.dateStamp == dateOf(with: Date())
            })
            self.quotes = quotes
            print(self.quotes)
        }
    }
    
    func likeQuote (quote: DiscoverQuote) {
        service.likeQuote(quote: quote)
    }
    
    func filterQuote(withTag tag: String) {
        return
    }

}
