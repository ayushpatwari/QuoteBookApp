//
//  QuoteBookAppApp.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 6/28/23.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct QuoteBookAppApp: App {
    @ObservedObject var model = ViewModel()
    @AppStorage("signIn") var isSignIn = false
    
    init() {
        FirebaseApp.configure()
        model.getCollection()
    }
    
    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environmentObject(tabModel())
//                .environmentObject(fabIconClass())
//        }
        
        
        
        WindowGroup {
            if !isSignIn {
                LoginScreen()
            } else {
                ContentView()
                    .environmentObject(tabModel())
                    .environmentObject(fabIconClass())
            }
        }
    }
}
