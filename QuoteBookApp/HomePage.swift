//
//  HomePage.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 10/14/23.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseFirestore

struct HomePage: View {
    
    
    @State private var user: User? = Auth.auth().currentUser // Get the current user
    @ObservedObject var model = ViewModel()
    @ObservedObject var libraryModel = LibraryViewModel()
    let hour : Int
    
    let screen = UIScreen.main.bounds
    
    init(){
        let date = Date()// Aug 25, 2017, 11:55 AM
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: date) //11
        
    }
    
    
    
    
    
    var body: some View
    {
        var quote = LibraryQuoteModel(id: "x", author: "John Smith", content: "Life is conumdrum of esoterica", likes: 0, createdAt: Date(), visibility: true, color: "N/A")
        
        
        
        
        NavigationView
        {
            Grid
            {
                GridRow
                {
                    
                    HStack
                    {
                        if let displayName = user?.displayName {
                            // Split the full name to get the first name
                            let fullNameComponents = displayName.split(separator: " ")
                            let firstName = String(fullNameComponents.first ?? "")
                            
                            if (hour < 12)
                            {
                                Text("Good Morning \(firstName)!")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                
                            }
                            else if (hour >= 12 && hour < 7)
                            {
                                Text("Good Afternoon \(firstName)!")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                            }
                            else
                            {
                                Text("Good Evening \(firstName)!")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                            }
                        }
                        Spacer()
                        
                        ProfileImageView()
                    }
                    .frame(width: self.screen.width, alignment: .top)
                    
                }
                
                GridRow
                {
                    
                    HStack
                    {
                        if let likedCollection = model.likedCollection
                        {
                            CollectionCard(collection: likedCollection)
                        }
                        
                        if let randomCollection = model.randomCollection
                        {
                            CollectionCard(collection: randomCollection)
                        }
                    } .onAppear {
                        model.getLikedCollection{ likedCollection in
                            model.likedCollection = likedCollection
                        }
                        
                        model.getRandomCollection { randomCollection in
                            model.randomCollection = randomCollection
                        }
                    }
                }
                
                GridRow
                {
                    VStack (alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack{
                                    Text(quote.author)
                                        .font(.custom("JosefinSans-Bold", size: 20))
                                        .lineLimit(1)
                                    Spacer()
                                    Menu{
                                        Button {
                                            //Code for adding to collection 💩
                                        } label: {
                                            Label("Add to collection", systemImage: "plus.square.on.square")
                                        }
                                        
                                        // Apply role: .destructive, so it becomes red 💩
                                        Button {
                                            libraryModel.deleteQuote(quoteToDelete: quote)
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
                                Text(quote.content)
                                    .font(.custom("JosefinSans-Regular", size: 17))
                            }
                            .padding()
                            
                        }
                        
                        //MARK: CHANGED THIS HSTACK
                        HStack{
                            Text(calcTimeSince(date: quote.createdAt))
                                .italic()
                                .padding(.vertical)
                                .padding(.leading)
                            Text(" · ")
                            Image(systemName: "heart.fill")
                            Text("\(quote.likes)")
                                .italic()
                        }
                        .foregroundColor(Color(#colorLiteral(red: 0.7706218274, green: 0.7706218274, blue: 0.7706218274, alpha: 1)))
                        .font(.custom("JosefinSans-Italic", size: 17))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: quote.color))
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    
                    //Make it so the background color changes from ColorPicker 💩
                    .cornerRadius(7)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .foregroundColor(.white)
            }
        }.frame(width: screen.width)
    }
}
