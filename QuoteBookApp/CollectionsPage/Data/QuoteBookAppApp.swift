//
//  QuoteBookAppApp.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 6/28/23.
//

import SwiftUI
import Firebase


@main
struct QuoteBookAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(collection: Collection.all)
        }
    }
}
