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

    
    @Namespace private var animation
    
    
    @State private var addCollection = false
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
                    AddCollectionView(addCollection: $addCollection, choosingQuotes: $chooseQuotes)
                        .frame(maxWidth: (chooseQuotes ? self.uiscreen.width/1.1 : self.uiscreen.width/1.25), maxHeight: (chooseQuotes ? self.uiscreen.height/1.175 : self.uiscreen.height/1.9)  )
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
    @StateObject private var selectedQuotes = quoteSelection()
    @State private var initalColor : Color = .clear
    @Binding var addCollection : Bool
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
                        Button("Choose your Quotes")
                        {
                            withAnimation(.spring())
                            {
                                choosingQuotes.toggle()
                            }
                        }
                        ColorPicker("ColorPicker", selection: $initalColor, supportsOpacity: false)
                                .labelsHidden()
                        Button("Done"){
                            withAnimation (.spring()){
                                model.addCollection(Name: name, color: initalColor.toHex() ?? "N/A")
                                addCollection.toggle()
                                
                                for quote in selectedQuotes.selectedQuotes
                                {
                                    model.addQuotes(quoteSelected: quote)
                                }
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
                        //Make it so the background color changes from ColorPicker 💩
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
