//
//  SingleQuote.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/12/23.
//

import SwiftUI
import Firebase

struct SingleQuote: View {
    @ObservedObject var viewModel = QuoteViewModel()
    @State var quote: DiscoverQuote
    @State private var isLiked = false
    let screen = UIScreen.main.bounds

    var body: some View{
        GeometryReader {geometry in
            ZStack {
                
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color(hex: quote.color)!, Color.randomGradientColor(hex: quote.color, deviation: 1.0)!]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .frame(width: screen.width, height: screen.height)
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .onTapGesture (count: 2) {
                            viewModel.likeQuote(quote: quote)
                            viewModel.checkIfUserLiked(quote: quote) { result in
                                self.isLiked = result
                            }
                        }
                VStack (spacing: 40) {
                    Spacer()
                    Text(quote.content)
                        .lineLimit(nil)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.leading, 250)
                        .padding(.trailing, 250)
                    Text("- \(quote.author)")
                        .font(.body)
                        .fontWeight(.semibold)
                    HStack (spacing: 100) {
                        //Like -> Depending on status of IfLiked this will fire
                        Button {
                            viewModel.likeQuote(quote: quote)
                            viewModel.checkIfUserLiked(quote: quote) { result in
                                self.isLiked = result
                            }
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(isLiked ? .pink : .white)
                                .font(.title2)
                                .onAppear {
                                    viewModel.checkIfUserLiked(quote: quote) { result in
                                        self.isLiked = result
                                    }
                                }
                            
                        }
                        Button {
                            print(quote.dateStamp)
                           
                        } label: {
                            Image(systemName: "book.fill")
                                .foregroundColor(Color.white)
                                .font(.title2)
                            
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "icloud.and.arrow.down.fill")
                                .foregroundColor(Color.white)
                                .font(.title2)
                            
                        }
                    }.padding()
                    Spacer()
                    
                }
                                
                            }
            
            .ignoresSafeArea()
            .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
}

