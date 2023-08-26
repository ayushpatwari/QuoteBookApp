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
    @ObservedObject var model = ViewModel()
    
    init() {
        FirebaseApp.configure()
        model.getCollection()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(collection: model.collections)
        }
    }
}
