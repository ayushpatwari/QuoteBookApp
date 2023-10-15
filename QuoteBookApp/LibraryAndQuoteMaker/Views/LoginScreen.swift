//
//  LoginScreen.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 8/26/23.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import Firebase
import FirebaseFirestore

struct LoginScreen: View {
    var body: some View {
        ZStack{
            Color("Primary")
                .ignoresSafeArea()
        GeometryReader { geometry in
            VStack{
                
                
                Image("Quotation Mark Image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                    .cornerRadius(50)
                    .ignoresSafeArea()
                
                Text("Welcome!")
                    .font(.custom("YoungSerif-Regular", size: 50))
                    .bold()
                GoogleSiginBtn {
                    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                    
                    let config = GIDConfiguration(clientID: clientID)
                    
                    GIDSignIn.sharedInstance.configuration = config
                    
                    GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { signResult, error in
                        
                        if let error = error {
                            //...
                            return
                        }
                        
                        guard let user = signResult?.user,
                              let idToken = user.idToken else { return }
                        
                        let accessToken = user.accessToken
                        
                        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                        
                        // Use the credential to authenticate with Firebase
                        
                        Auth.auth().signIn(with: credential) { signResult, error in
                            guard error == nil else {
                                return
                            }
                            guard let userID = signResult?.user.uid else { return }
                            
                            let db = Firestore.firestore()
                            
                            db.collection("users").document(userID).collection("collections").addDocument(data: [:])
                            
                            
                            
                            
                            print(userID)
                            
                            print("SIGN IN")
                            UserDefaults.standard.set(true, forKey: "signIn")
                        }
                        
                    }
                    
                }
                .padding()
                
            }
        }
    }
    }
    
    init(){
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
