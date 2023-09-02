//
//  ContentView.swift
//  QuoteBook

import SwiftUI
import Firebase



struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State private var showingAddView = false
    @State var refresh = Refresh(started: false, released: false)
    
    
    
    var body: some View {
        
        ZStack (alignment: .bottomTrailing){
            NavigationView {
                ScrollView{
                    GeometryReader{reader -> AnyView in
                        DispatchQueue.main.async {
                            if refresh.startOffset == 0 {
                                refresh.startOffset = reader.frame(in: .global).minY
                            }
                            
                            refresh.offset = reader.frame(in: .global).minY
                            
                            if refresh.offset - refresh.startOffset > 80 && !refresh.started{
                                refresh.started = true
                            }
                            
                            if refresh.startOffset == refresh.offset && refresh.started && !refresh.released{
                                withAnimation(Animation.linear){refresh.released = true}
                                updateData()
                            }
                            
                            if refresh.startOffset == refresh.offset && refresh.started && refresh.released && refresh.invalid {
                                refresh.invalid = false
                                updateData()
                            }
                            
                        }
                        return AnyView(Color.black.frame(width: 0, height: 0))
                    }
                    .frame(width: 0, height: 0)
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                        
                        if refresh.started && refresh.released{
                            ProgressView()
                                .offset(y: -35)
                        } else {
                            VStack{
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                        .frame(width: 30, height: 30)
                                    
                                    Image(systemName: "arrow.down")
                                        .font(.system(size: 16, weight: .heavy))
                                        .foregroundColor(.gray)
                                        .rotationEffect(.init(degrees: refresh.started ? 180 : 0))
                                }
                                Text("Pull To Refresh")
                            }
                            .opacity(refresh.started == true ? 1 : 0)
                            .animation(.easeIn)
                            .offset(y: -100)
                        }
                        
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
                                                        .bold()
                                                        .font(.title3)
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
                                                    .font(.system(size: 17))
                                            }
                                            .padding()
                                            
                                        }
                                        Text(calcTimeSince(date: quote.createdAt))
                                            .foregroundColor(Color(#colorLiteral(red: 0.7706218274, green: 0.7706218274, blue: 0.7706218274, alpha: 1)))
                                            .italic()
                                            .padding()
                                        
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(Color(#colorLiteral(red: 0, green: 0.5, blue: 0.4812854786, alpha: 1)))
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
                    .offset(y: refresh.released ? 40 : -10)
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
    
    init() {
        model.getDataForCurrentUser() // Fetch quotes for the current user
    }

    
    func updateData() {
        print("update Data...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            model.getDataForCurrentUser() // Fetch quotes for the current user
            withAnimation(Animation.linear){
                if refresh.startOffset == refresh.startOffset {
                    refresh.released = false
                    refresh.started = false
                } else {
                    refresh.invalid = true
                }
            }
        }
    }

}



struct Refresh {
    var startOffset : CGFloat = 0
    var offset : CGFloat = 0
    var started : Bool
    var released : Bool
    var invalid : Bool = false
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
