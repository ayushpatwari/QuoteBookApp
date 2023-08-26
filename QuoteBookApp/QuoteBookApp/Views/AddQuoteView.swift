//
//  ContentView.swift
//  QuoteBook

import SwiftUI
import CoreData



struct AddQuoteView: View {
    @State private var showingAddView = false
    
    let Quote: [Quote]
    
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            NavigationView {
                ScrollView{
                    VStack(alignment: .leading){
                        ForEach(Quote) { Quote in
                                VStack (alignment: .leading) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 6) {
                                            HStack{
//                                                Text(Quote.author!)
//                                                    .bold()
//                                                    .font(.title3)
//                                                    .lineLimit(1)
                                                Spacer()
                                                Menu{
                                                    
                                                    Button {
                                                        //Code for adding to collection 💩
                                                    } label: {
                                                        Label("Add to collection", systemImage: "plus.square.on.square")
                                                    }
                                                    
                                                    // Apply role: .destructive, so it becomes red 💩
                                                    Button {
//                                                        deleteQuote(for: userQuote)
                                                    } label: {
                                                        Label("Delete", systemImage: "trash")
                                                    }
                                                    
                                                } label: {
                                                    ZStack {
                                                        Circle()
                                                            .foregroundColor(Color(#colorLiteral(red: 0.9489397407, green: 0.9490725398, blue: 0.948897779, alpha: 1)))
                                                            .frame(width: 30, height: 30)
                                                        
                                                        Image(systemName: "ellipsis")
                                                        
                                                    }
                                                    .scaleEffect(1.3)
                                                    .padding(5)
                                                }
                                                .onTapGesture {
                                                    
                                                }
                                            }
//                                            Text(Quote.quote!)
//                                                .font(.system(size: 17))
                                        }
                                        .padding()
                                        
                                    }
//                                    Text(calcTimeSince(date: userQuote.date!))
                                        .foregroundColor(Color(#colorLiteral(red: 0.7706218274, green: 0.7706218274, blue: 0.7706218274, alpha: 1)))
                                        .italic()
                                        .padding()
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .background(Color(#colorLiteral(red: 0, green: 0.5, blue: 0.4812854786, alpha: 1)))
                                //Make it so the background color changes from ColorPicker 💩
                                .cornerRadius(7)
                        }
                        .navigationTitle("QuoteBook")
                    }
                }
            }
            Button {
                showingAddView.toggle()
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //I would add an animation when you click the button, like a pulse animation or confetti on the AddQuote screen 💩
                }
                .frame(width: 57, height: 57)
                .padding()
            }
            .sheet(isPresented: $showingAddView) {
                AddQuoteView()
            }
        }
        
    }
//    private func deleteQuote(for quote: Quote) {
//        withAnimation {
//            managedObjContext.delete(quote)
//            DataController().save(context: managedObjContext)
//        }
//    }
}
