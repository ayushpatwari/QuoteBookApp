//
//  ContentView.swift
//  discoverPage
//
//  Created by Vishal Varma on 6/28/23.
//

import SwiftUI

struct DiscoverPage: View {
    @ObservedObject var viewModel = QuoteViewModel()
    @State var currentQuote: String = ""
    let screen = UIScreen.main.bounds
    @State var searchText: String = ""
    @State var show: Bool = false
    
    var body: some View {
        ZStack (alignment: .topTrailing){
            VStack {
                
                ScrollView(.init())
                {
                    GeometryReader { proxy in
                        let size = proxy.frame(in: .global)
                        
                        TabView (selection: $currentQuote) {
                            ForEach(viewModel.searchedQuotes) {quote in
                                SingleQuote(quote: quote)
                                    .frame(width: size.width, height: size.height)
                                    .rotationEffect(.init(degrees: -90))
                                    .frame(width: size.width, height: size.height)
                                    
                            }
                            .ignoresSafeArea()
                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .rotationEffect(.init(degrees:90))
                            .frame(width: size.width)
                            .frame(height: size.height)
                            .edgesIgnoringSafeArea(.top)
                        
                    }
                    .frame(
                        width: screen.height,
                        height: screen.width
                    )
                }
                .ignoresSafeArea()
                
            }
            
            HStack {
                if show {
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
            }
            .padding(.horizontal, 4)
            ProfileImageView()
                .padding()
            
            TabBar()
            
        }
    }
        
}



