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
        fetchInitialQuotes()
        isProblematic()
    }
    
    func fetchInitialQuotes () -> Void{
        service.fetchInitialQuotes{ quotes in
            self.quotes2 = quotes.filter({
                $0.dateStamp == dateOf(with: Date())
            })
            self.quotes = quotes
            print(self.quotes)
        }
    }
    
    func isProblematic() -> Void {
        if self.quotes2.count < 3 {
            print(self.quotes)
            setQuotesToDay(date: findDayBefore(date: Date()))
        } else {
            self.quotes = self.quotes2
        }
        
    }
    
    func setQuotesToDay(date: Date) {
        print("DEBUG: Date considered is " + dateOf(with: date))
        var filters = [DiscoverQuote]()
        for quote in self.quotes {
            print("DEBUG: Filter Began")
            if quote.dateStamp == dateOf(with: date) {
                print("DEBUG: I was added \(quote)")
                filters.append(quote)
            }
        }
        if filters.count < 3 && dateOf(with: date) != "2023-08-19"{
            print(filters)
            setQuotesToDay(date: findDayBefore(date: date))
        } else if dateOf(with: date) == "2023-08-19" {
            self.quotes = filters
        }
    }
    
    func likeQuote (quote: DiscoverQuote) {
        service.likeQuote(quote: quote)
    }
    
    func filterQuote(withTag tag: String) {
        return
    }

}
