//
//  discoverPageApp.swift
//  discoverPage
//
//  Created by Vishal Varma on 6/28/23.
//

import SwiftUI
import Firebase

@main
struct discoverPageApp: App {
   
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
