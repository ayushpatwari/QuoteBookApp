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
    @State var quote: Quote
    let screen = UIScreen.main.bounds

    var body: some View{
        GeometryReader {geometry in
            ZStack {
                
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color(hex: quote.color)!, Color.randomGradientColor(hex: quote.color, deviation: 1.0)!]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                    .frame(width: .infinity, height: .infinity)
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
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
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.white)
                                .font(.title2)
                            
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

struct SingleQuote_Previews: PreviewProvider {
    static var previews: some View {
        SingleQuote(quote: Quote(content: "HI", author: "HI", likes: 45, color: "YELLOW", isQOTD: true, visibility: false))
    }
}

