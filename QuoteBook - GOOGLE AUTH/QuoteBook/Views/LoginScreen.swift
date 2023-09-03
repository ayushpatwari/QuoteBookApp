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

struct LoginScreen: View {
    var body: some View {
        VStack{
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
                        print(userID)

                        print("SIGN IN")
                        UserDefaults.standard.set(true, forKey: "signIn")
                    }
                    
                }
                
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
