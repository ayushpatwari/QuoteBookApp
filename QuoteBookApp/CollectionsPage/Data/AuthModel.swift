//
//  AuthModel.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/28/23.
//

import Foundation
import Firebase

class AuthModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
}
