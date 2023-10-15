//
//  ContentView.swift
//  QuoteBook

import SwiftUI
import Firebase



struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State private var showingAddView = false
    @Environment(\.colorScheme) var colorScheme
    
    
    
    var body: some View{
        
        ZStack (alignment: .bottomTrailing){
            NavigationView {
                ZStack{
                    if colorScheme == .dark {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.01283317432, green: 0.5592082739, blue: 0.9879719615, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.1608584225, green: 0.2227621973, blue: 0.48106426, alpha: 1)).opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                    } else {
                        LinearGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.383777827, green: 0.8484751582, blue: 1, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.6233523488, green: 0.764604032, blue: 0.9187348485, alpha: 1)).opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
                        
                    }
                    
                    ZStack{
                        Circle()
                            .frame(width: 400, height: 400)
                            .offset(x: 150, y: -200)
                            .foregroundColor(Color(#colorLiteral(red: 0.3577034228, green: 0.3583272618, blue: 0.9274514318, alpha: 1)).opacity(0.5))
                            .blur(radius: 5)
                        Circle()
                            .frame(width: 300, height: 300)
                            .offset(x: -100, y: -125)
                            .foregroundColor(Color(#colorLiteral(red: 0.06556713664, green: 0.6905337576, blue: 0.7830337063, alpha: 1)).opacity(0.5))
                            .blur(radius: 5)
                        ScrollView{
                            
                            VStack(alignment: .leading){
                                
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
                                .navigationTitle("QuoteBook")
                                
                            }
                            
                        }
                    }
                }
                
                
            }
            
            TabBar()
        }
    }
    
    init() {
        model.getDataForCurrentUser() // Fetch quotes for the current user
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "YoungSerif-Regular", size: 34)!]

        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "YoungSerif-Regular", size: 20)!]

        
        UINavigationBar.appearance().barTintColor = .init(Color("Primary"))
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
