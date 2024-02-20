//
//  QuoteViewModel.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/25/23.
//

import Foundation

final class QuoteViewModel: ObservableObject {
    let service = QuoteService()
    @Published var quotes = [Quote]()
    @Published var quotes2 = [Quote]()
    @Published var searchText: String = ""
    @Published var searchable: Bool = false
    
    
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
        service.likeQuote(quote: quote)
    }
        
    func filterQuote(withTag tag: String) {
        return
    }
}
