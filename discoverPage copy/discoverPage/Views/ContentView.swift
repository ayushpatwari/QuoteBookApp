//
//  ContentView.swift
//  discoverPage
//
//  Created by Vishal Varma on 6/28/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = QuoteViewModel()
    @State var currentQuote: String = ""
    let screen = UIScreen.main.bounds
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    let size = proxy.frame(in: .global)
                    
                    TabView (selection: $currentQuote) {
                        ForEach(viewModel.quotes) {quote in
                            SingleQuote(quote: quote)
                                .rotationEffect(.init(degrees: -90))
                                .frame(height: size.height)
                                .onTapGesture (count: 2) {
                                    viewModel.likeQuote(quote: quote)
                                }
                        }
                        .ignoresSafeArea()
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .rotationEffect(.init(degrees:90))
                        .frame(width: size.width)
                        .frame(height: size.height)
                        .edgesIgnoringSafeArea(.top)
                    
                }.frame(
                    width: screen.height,
                    height: screen.width
                )
            }
            
            HStack {
                TextField("Search.....", text: $viewModel.searchText)
                    .padding(8)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: screen.width, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    
                    )
                    .opacity(0.6)
            }
            .padding(.horizontal, 4)
        }
    }
        
}
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

