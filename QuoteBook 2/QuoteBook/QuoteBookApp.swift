//
//  QuoteBookApp.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 6/30/23.
//

import SwiftUI
import Firebase

@main
struct QuoteBookApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
