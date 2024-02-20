//
//  AuthViewModel.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/28/23.


import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
}
