//
//  ProfileImageView.swift
//  discoverPage
//
//  Created by Ayush Patwari on 10/14/23.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct ProfileImageView: View {
    @State private var user: User? = Auth.auth().currentUser
    @ObservedObject var model = LibraryViewModel()
    
    
    
    var body: some View {
        if let user = user {
            if let profilePicUrl = user.photoURL {
                Menu {
                    Button {
                        let firebaseAuth = Auth.auth()
                        do {
                            print("SIGN OUT")
                            UserDefaults.standard.set(false, forKey: "signIn")
                            try firebaseAuth.signOut()
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    WebImage(url: profilePicUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:60, height:60)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Color.white, lineWidth: 3))
                }
            }
        }
    }
}
