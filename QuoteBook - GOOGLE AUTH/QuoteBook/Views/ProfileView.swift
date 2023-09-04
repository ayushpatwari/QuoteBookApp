import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI
import FirebaseAuth
import OmenTextField

struct ProfileView: View {
    @ObservedObject var viewModel = ViewModel()

    @State private var user: User? = Auth.auth().currentUser // Get the current user
    @State private var lifeQuote = ""
    @State private var totalQuotesCount = 0 // Add this property

    
    
    
    var body: some View {
        NavigationView {
        VStack{
            if let user = user {
                if let profilePicUrl = user.photoURL {
                    
                    WebImage(url: profilePicUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                }
                
                Text("\(user.displayName ?? "User")")
                    .font(.title)
                    .bold()
                    .padding()
                
                if let displayName = user.displayName {
                    // Split the full name to get the first name
                    let fullNameComponents = displayName.split(separator: " ")
                    let firstName = String(fullNameComponents.first ?? "")
                    
                    Text("Quote of \(firstName)'s Life")
                        .font(.title3)
                        .bold()
                }
                
                
                HStack{
                    ZStack(alignment: .topTrailing){
                        Spacer()
                        
                        OmenTextField("Type the Quote of Your Life Here", text: $lifeQuote)

                            .padding(.horizontal, 15)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        
                        Spacer()
                        
                    }
                }
                .padding(.horizontal, 30)
                .padding()
                
                
                
                
                
                HStack{
                    Spacer()
                    Text("Total Likes")
                        .bold()
                    
                    Spacer()
                    VStack{
                        Text("Total Quotes")
                            .bold()
                        Text("\(totalQuotesCount)") // Display the totalQuotesCount here
                                        .bold()
                                        .foregroundColor(.black)
                                        .font(.title3)
                    }
                    
                    Spacer()
                    
                    Text("Total Collections")
                        .bold()
                    
                    Spacer()
                    
                }
                .font(.headline)
                .foregroundColor(.gray)
            }
        }
        .onAppear {
            // Fetch and update the lifeQuote from Firebase Firestore
            viewModel.fetchLifeQuote { fetchedLifeQuote in
                lifeQuote = fetchedLifeQuote
            }

            // Fetch the totalQuotes count from Firebase
            if let currentUserUID = user?.uid {
                viewModel.fetchTotalQuotesCount(forUserUID: currentUserUID) { count in
                    totalQuotesCount = count
                }
            }
        }

        .padding()
        .navigationTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    saveLifeQuote()
                }) {
                    Text("Save")
                }
            }
        }
    }

    }
    
    func saveLifeQuote() {
        viewModel.updateLifeQuote(newLifeQuote: lifeQuote)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
