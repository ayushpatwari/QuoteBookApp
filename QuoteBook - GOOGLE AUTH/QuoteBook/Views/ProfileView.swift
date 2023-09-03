import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @State private var user: User? = Auth.auth().currentUser // Get the current user
    
    var body: some View {
        if let user = user {
            // User is signed in, you can access the profile information here
            Text("Hello, \(user.displayName ?? "User")") // Display the user's display name

            // You can access other profile information as needed
            Text("Email: \(user.email ?? "No email available")")

            if let profilePicUrl = user.photoURL {
                // Display the user's profile picture if available
                WebImage(url: profilePicUrl) // Use WebImage from SDWebImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
        } else {
            // User is not signed in, you can show a message or sign-in button
            Text("Please sign in to view your profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
