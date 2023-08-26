//
//  SingleQuote.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/12/23.
//

import SwiftUI

struct SingleQuote: View {
    
    @State var quote: Quote
    @ObservedObject var viewModel = QuoteViewModel()
    let screen = UIScreen.main.bounds

    var body: some View{
        GeometryReader {geometry in
            ZStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [colorFromString(quote.color), colorFromFirstColor(quote.color)]),
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
                            print("DEBUG: Just Shared")
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

/*
struct SingleQuote_Previews: PreviewProvider {
    static var previews: some View {
        SingleQuote(quote: Quote(content: "All men are created equal", author: "yesman", likes: 43, color: "yellow", isQOTD: true, timestamp: nil))
    }
}
*/
