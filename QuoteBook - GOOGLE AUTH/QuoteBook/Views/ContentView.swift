//
//  ContentView.swift
//  QuoteBook

import SwiftUI
import Firebase



struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State private var showingAddView = false
    @State private var showingProfileView  = false
    @State private var isProfileViewPresented = false
    
    
    
    var body: some View{
        
        ZStack (alignment: .bottomTrailing){
            NavigationView {
                ZStack{
                    Color("Primary")
                        .ignoresSafeArea()
                    ScrollView{
                        
                        
                        VStack(alignment: .leading){
                            
                            Button("Sign Out") {
                                let firebaseAuth = Auth.auth()
                                do {
                                    print("SIGN OUT")
                                    UserDefaults.standard.set(false, forKey: "signIn")
                                    try firebaseAuth.signOut()
                                } catch let signOutError as NSError {
                                    print("Error signing out: %@", signOutError)
                                }
                                
                            }
                            
                            ForEach(model.quotes) { quote in
                                NavigationLink(destination: EditQuoteView(quote: quote)) {
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
                                                            model.deleteQuote(quoteToDelete: quote)
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
                                        HStack{
                                            Text(calcTimeSince(date: quote.createdAt))
                                                .foregroundColor(Color(#colorLiteral(red: 0.7706218274, green: 0.7706218274, blue: 0.7706218274, alpha: 1)))
                                                .font(.custom("JosefinSans-Italic", size: 17))
                                                .italic()
                                                .padding()
                                            Spacer()
                                            Image(systemName: "heart.fill")
                                                .padding()
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: quote.color))
                                    //Make it so the background color changes from ColorPicker 💩
                                    .cornerRadius(7)
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .foregroundColor(.white)
                                
                            }
                            .navigationTitle("QuoteBook")
                            
                        }
                        
                    }
                }
            }
            
            
            
            
            TabBar()
        }
        
        
    }
    
    init() {
        model.getDataForCurrentUser() // Fetch quotes for the current user
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "YoungSerif-Regular", size: 34)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "YoungSerif-Regular", size: 20)!]
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
