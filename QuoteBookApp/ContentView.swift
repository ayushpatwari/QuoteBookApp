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
    
    @EnvironmentObject var tabModel: tabModel
//    @EnvironmentObject var viewModel : AuthViewModel
    
    
//    let collection: [Collection]
    
    
    var body : some View {
        
        
        if tabModel.selectedTab == "discover"
        {
            DiscoverPage()
        }
        else if tabModel.selectedTab == "collection"
        {
            CollectionsView()
        }
        else if tabModel.selectedTab == "library"
        {
            LibraryView()
        }
        else if tabModel.selectedTab == "home"
        {
            HomePage()
        }
    }
}

    
