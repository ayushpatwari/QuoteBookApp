//
//  CollectionsView.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 7/23/23.
//

import SwiftUI

import Foundation

class quoteSelection : ObservableObject
{
    @Published var selectedQuotes : [String] = []
}


struct CollectionsView: View
{
    @ObservedObject var model = ViewModel()
    @EnvironmentObject  var addCollectionClass : fabIconClass
    
    
    
    
    @Namespace private var animation
    
    @State private var chooseQuotes = false
    
    let uiscreen = UIScreen.main.bounds
    
    var body: some View
    {
        ZStack{
            Color("Primary")
                .ignoresSafeArea()
            
            if (addCollectionClass.addCollection == false)
            {
                
                VStack {
                    
                    //view that contains all the collections
                    NavigationView
                    {
                        ScrollView(.vertical)
                        {
                            LazyVGrid (columns: [GridItem(.flexible()), GridItem(.flexible())])
                            {
                                ForEach(model.collections) { collection in
                                    NavigationLink(destination: CollectionsEditor(collection: collection)) {
                                        CollectionCard(collection: collection)
                                    }
                                }
                                .navigationTitle("Collections")
                            }
                        }
                        .background(Color("Primary"))
                    }
                    .frame(width: self.uiscreen.width, alignment: .center)
//                    .blur(radius: (addCollectionClass.addCollection ? 20 : 0))
                }
            }
            if (addCollectionClass.addCollection == false)
            {
                
                TabBar()
                
            }
            
            
            if (addCollectionClass.addCollection)
            {
                AddCollectionView(choosingQuotes: $chooseQuotes)
                    .frame(maxWidth: (chooseQuotes ? self.uiscreen.width/1.1 : self.uiscreen.width/1.25), maxHeight: (chooseQuotes ? self.uiscreen.height/1.175 : self.uiscreen.height/1.9)  )
                    .cornerRadius(25)
                    .matchedGeometryEffect(id: "choosequotes", in: animation)
                
                
            }
        }
        .background(Color("Primary"))
    }
    
    init()
    {
        model.getCollection()
        UINavigationBar.appearance().barTintColor = .init(Color("Primary"))
    }
}



//view that shows the add collection screen
struct AddCollectionView: View
{
    @StateObject private var selectedQuotes = quoteSelection()
    @EnvironmentObject var addCollectionClass : fabIconClass
    @State private var initalColor : Color = .clear
    @ObservedObject var model = ViewModel()
    @State private var name  = ""
    @Binding var choosingQuotes : Bool
    var body : some View
    {
        
        //code that selects quotes -> rithik code
        if (choosingQuotes)
        {
            VStack
            {
                chooseQuoteView()
                    .environmentObject(selectedQuotes)
                Button("Done")
                {
                    withAnimation(.spring())
                    {
                        choosingQuotes.toggle()
                    }
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
                        Button("Choose Your Quotes")
                        {
                            withAnimation(.spring())
                            {
                                choosingQuotes.toggle()
                            }
                        }
                        
                        //we need to add
                        ColorPicker("ColorPicker", selection: $initalColor, supportsOpacity: false)
                            .labelsHidden()
                        Button("Done"){
                            withAnimation (.spring()){
                                model.addCollection(Name: name, color: initalColor.toHex() ?? "N/A", quoteSelected: selectedQuotes.selectedQuotes)
                                addCollectionClass.addCollection.toggle()
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .font(.custom("YoungSerif-Regular", size: 30))
                    .fontWeight(.bold)
                    .padding()
                    .frame(alignment: .center)
                }
            }
            
        }
    }
    
    
}



struct chooseQuoteView : View {
    
    @ObservedObject var model = ViewModel()
    @EnvironmentObject var quotesSelected : quoteSelection
    
    var body : some View
    {
        ScrollView
        {
            
            Text("Quotes")
                .font(.largeTitle)
                .frame(alignment: .leading)
            
            VStack(alignment: .leading){
                ForEach(model.quotes) { quote in
                    
                    Button {
                        quotesSelected.selectedQuotes.append(quote.id)
                    } label: {
                        VStack (alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack{
                                        Text(quote.author + " · " + calcTimeSince(date: quote.createdAt))
                                            .bold()
                                            .font(.title3)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                    Text(quote.content)
                                        .font(.system(size: 17))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0, green: 0.5, blue: 0.4812854786, alpha: 1)))
                        .cornerRadius(7)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    
                }
            }
            .padding()
        }
    }
    
    init()
    {
        model.getAllQuotes()
    }
}

struct CollectionCard: View {
    var collection : Collection
    var body: some View {
        Text(collection.name)
            .fixedSize(horizontal: false, vertical: false)
            .multilineTextAlignment(.leading)
            .padding()
            .frame(width: 155, height: 155)
            .background(
                Rectangle()
                    .foregroundColor(Color(hex: collection.color) ?? .gray)
                    .opacity(0.3)
                    .cornerRadius(25)
                    .blur(radius: 1))
            .padding()
    }
}

struct CollectionsEditor: View {
    
    @ObservedObject var model = ViewModel()
    var collection: Collection
    @State private var intialColor : Color
    @State private var name = ""
    
    
    init(collection: Collection)
    {
        self.collection = collection
        self._intialColor = State(initialValue: Color(hex: collection.color) ?? .clear)
    }
    var body: some View {
        Text(collection.name)
        
        Button
        {
            model.deleteCollection(collection: collection)
        } label: {
            Image(systemName: "xmark")
        }
        
        Text("Car")
        Form
        {
            TextField("Collection Name", text: $name)
                .multilineTextAlignment(.center)
            
            //we need to add
            ColorPicker("ColorPicker", selection: $intialColor, supportsOpacity: false)
                .labelsHidden()
            Button("Done"){
                withAnimation (.spring()){
                    model.updateCollection(collection: collection, newName: name, newColor: intialColor.toHex() ?? "N/A")
                }
            }
        }
        .foregroundColor(.black)
        .font(.custom("YoungSerif-Regular", size: 30))
        .fontWeight(.bold)
        .padding()
        .frame(alignment: .center)
    }
}
