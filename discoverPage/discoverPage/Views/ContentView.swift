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
    @State var show: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                GeometryReader { proxy in
                    let size = proxy.frame(in: .global)
                    
                    TabView (selection: $currentQuote) {
                        ForEach(viewModel.searchedQuotes) {quote in
                            SingleQuote(quote: quote)
                                .rotationEffect(.init(degrees: -90))
                                .ignoresSafeArea(.all, edges:.top)
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
            Text("Profile")
                .frame(width:50)
                .offset(x:50, y:-350)
                .font(.subheadline)
            Circle()
                .frame(width:75, height: 75)
                .offset(x:120, y:-350)
                .opacity(0.6)
            
        }
        
        
        VStack{
            HStack {
                Text("Profile")
                    .frame(width: 50)
                    .font(.subheadline)
                Circle()
                    .frame(width: 60, height: 60)
            }.offset(x:120, y: -350)
            
        }

        
    }
        
}
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

