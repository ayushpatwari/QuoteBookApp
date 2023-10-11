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
    @StateObject var viewModel: MyModel = MyModel()
    
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
    }
}

    
