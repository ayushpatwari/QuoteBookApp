//
//  ContentView.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 6/28/23.
//

import SwiftUI


struct ContentView: View
{
    @State private var addCollection = false
    
    
//    @EnvironmentObject var viewModel : AuthViewModel
    
    
    let collection: [Collection]
    
    
    var body : some View {
        
        CollectionsView()

        
    }
}

