//
//  CollectionsView.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/23/23.
//

import SwiftUI

import Foundation


struct CollectionsView: View
{
    @ObservedObject var model = ViewModel()
    
    @Namespace private var animation
    
    
    @State private var addCollection = false
    @State private var name: String = ""
    @State private var chooseQuotes = false
    
    let uiscreen = UIScreen.main.bounds

    var body: some View
    {
        
        ZStack{
            
            if (addCollection == false)
            {
                VStack(alignment: .center)
                {
                    //title
                    Text("Collections")
                        .padding(.bottom)
                        .fontWeight(.semibold)
                    
                    //view that contains all the collections
                    NavigationView{
                        ScrollView(.vertical)
                        {
                            LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible())])
                            {
                                ForEach(model.collections) { collection in
                                    NavigationLink(destination: CollectionsEditor(collection: collection)) {
                                        CollectionCard(collection: collection)
                                    }
                                }
                            }
                        }
                    }
                    
                    //button to add a new collection
                        
                        Button() {
                            withAnimation(.spring())
                            {
                                addCollection.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 65, height: 65, alignment: .trailing)
                        }
                        .frame(width: self.uiscreen.width - self.uiscreen.width/9, alignment: .bottomTrailing)
                    .padding()
                    .padding(.horizontal)
                    Spacer()
                }
                .frame(width: self.uiscreen.width, alignment: .center)
                .blur(radius: (addCollection ? 20 : 0))
            }
            if (addCollection == false)
            {
                TabBar()
            }

            
            if (addCollection)
            {
                withAnimation(.bouncy()) {
                    AddCollectionView(name: name, addCollection: $addCollection, choosingQuotes: $chooseQuotes)
                        .frame(maxWidth: (chooseQuotes ? self.uiscreen.width/1.1 : self.uiscreen.width/1.25), maxHeight: (chooseQuotes ? self.uiscreen.height/1.25 : self.uiscreen.height/1.9)  )
                        .background(
                            Color("Color"))
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "choosequotes", in: animation)
                }
                
            }
        }
    }
    
    init()
    {
        model.getCollection()
    }
    
}



//view that shows the add collection screen
struct AddCollectionView: View
{
    @ObservedObject var model = ViewModel()
    @State var name : String
    @Binding var addCollection : Bool
    @Binding var choosingQuotes : Bool
    var body : some View
    {
        
        //code that selects quotes -> rithik code
        if (choosingQuotes)
        {
            
            
            
            
            
            Button("Done")
            {
                withAnimation(.spring())
                {
                    choosingQuotes.toggle()
                }
            }
        } else {
            ZStack
            {
                VStack {
                    Form
                    {
                        TextField("Collection Name", text: $name)
                            .multilineTextAlignment(.center)
                        Button("Choose your Quotes")
                        {
                            withAnimation(.spring())
                            {
                                choosingQuotes.toggle()
                            }
                        }
                        Button("Done"){
                            withAnimation (.spring()){
                                addCollection.toggle()
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding()
                    .frame(alignment: .center)
                }
            }
            
        }
    }
}

struct CollectionCard: View {
    var collection: Collection
    
    var body: some View {
        let color = "red"
        Text(collection.name)
            .fixedSize(horizontal: false, vertical: false)
            .multilineTextAlignment(.leading)
            .padding()
            .frame(width: 155, height: 155)
            .background(
                Rectangle()
                    .foregroundColor(.blue) // this needs to be the custom color -> input rithik code
                    .opacity(0.3)
                    .cornerRadius(25)
                    .blur(radius: 1))
            .padding()
    }
}

struct chooseQuoteView : View {
    
    
    var body : some View {
        
        
        Text("Car")
    }
}
