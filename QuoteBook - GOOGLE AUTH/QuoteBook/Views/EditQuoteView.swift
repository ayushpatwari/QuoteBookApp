//
//  EditQuoteView.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 7/8/23.
//
import SwiftUI
import Firebase


struct EditQuoteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = ViewModel()
    
    
    @State var content : String
    @State var author : String
    @State var color : Color
    
    @State var quote : Quote
    @State var visibility : Bool
    @State private var isPublic: Bool = false
    @State private var tagsIsSelected = true
    @State private var showingTagSelectionView = false
    
    @State private var emptyContent: Bool = false
    @State private var numberOfShakes: Int = 0
    let words = ""
    
    
    init(quote: Quote){
        self._content = State(initialValue: quote.content)
        self._author = State(initialValue: quote.author)
        self._quote = State(initialValue: quote)
        self._visibility = State(initialValue: quote.visibility)
        self._isPublic = State(initialValue: quote.visibility)
        self._color = State(initialValue: Color(hex: quote.color) ?? .clear)
        
        
        UITableView.appearance().contentInset.top = -25
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            Color("Primary")
                .ignoresSafeArea()
            VStack(alignment: .leading){
                Text("Edit quote")
                    .bold()
                    .font(.custom("JosefinSans-Regular", size: 23))
                    .offset(x: 0, y: -35)
                Text("Quote")
                    .bold()
                    .font(.custom("JosefinSans-Regular", size: 20))
                
                HStack{
                    Image(systemName: "text.quote")
                        .padding(.leading)
                        .opacity(0.5)
                    
                    TextField("Quote", text: $content /*, axis: .vertical 💩*/)
                        .frame(height: 50)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal])
                        .padding([.horizontal], 0)
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(emptyContent == true ? Color.red : Color.primary))
                .modifier(Shake(animatableData: CGFloat(numberOfShakes)))
                
                if(emptyContent == true){
                    Text("Quote is too short")
                        .foregroundColor(.red)
                        .font(.callout)
                }
                
                
                Text("Author")
                    .bold()
                    .font(.custom("JosefinSans-Regular", size: 20))
                
                HStack{
                    Image(systemName: "person.fill")
                        .padding(.leading)
                        .opacity(0.5)
                    
                    TextField("Author", text: $author)
                    
                        .frame(height: 50)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal])
                        .padding([.horizontal], 0)
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primary))
                
                
                
                
                Text("Properties")
                    .bold()
                    .font(.custom("JosefinSans-Regular", size: 20))
                    .padding(.top, 10)
                
                
                if #available(iOS 16.0, *) {
                    Form{
                        Section{
                            
                            HStack{
                                Image(systemName: "tag.fill")
                                    .scaleEffect(x: -1, y: 1)
                                Text("Label")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                
                                Spacer()
                                //MARK: CURRENT WORKSPACE
                                Button {
                                    showingTagSelectionView.toggle()
                                } label: {
                                    HStack{
                                        Image(systemName: "plus")
                                        
                                        if tagsIsSelected == false {
                                            Text("Add Tag")
                                                .bold()
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .frame(height: 36)
                                    .cornerRadius(18)
                                    .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                
                            }
                            
                            
                            HStack{
                                Image(systemName: "eyedropper")
                                Text("Color")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                
                                Spacer()
                                
                                ColorPicker("", selection: $color, supportsOpacity: false)
                                
                            }
                            
                            HStack{
                                Image(systemName: visibility ? "eye" : "eye.slash")
                                
                                Toggle(isOn: $visibility) {
                                    Text(visibility ? "Public" : "Private")
                                        .font(.custom("JosefinSans-Regular", size: 20))
                                }
                                
                                
                                Spacer()
                                
                            }
                            
                        }
                        .cornerRadius(25)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    Form{
                        Section{
                            
                            HStack{
                                Image(systemName: "tag.fill")
                                    .scaleEffect(x: -1, y: 1)
                                Text("Label")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                
                                Spacer()
                                //MARK: CURRENT WORKSPACE
                                Button {
                                    showingTagSelectionView.toggle()
                                } label: {
                                    HStack{
                                        Image(systemName: "plus")
                                        
                                        if tagsIsSelected == false {
                                            Text("Add Tag")
                                                .bold()
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .frame(height: 36)
                                    .cornerRadius(18)
                                    .overlay(Capsule().stroke(Color.blue, lineWidth: 1))
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                
                            }
                            
                            
                            HStack{
                                Image(systemName: "eyedropper")
                                Text("Color")
                                    .font(.custom("JosefinSans-Regular", size: 20))
                                
                                Spacer()
                                
                            }
                            
                            HStack{
                                Image(systemName: visibility ? "eye" : "eye.slash")
                                
                                Toggle(isOn: $visibility) {
                                    Text(visibility ? "Public" : "Private")
                                        .font(.custom("JosefinSans-Regular", size: 20))
                                }
                                
                                
                                Spacer()
                                
                            }
                            
                        }
                        .cornerRadius(25)
                    }
                }
                
                
                
                
                if visibility && !isPublic {
                    Text("Note: This quote will be made public to everyone - it cannot be made private once published.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                }
                
                
                HStack {
                    Spacer()
                    let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
                    let words = trimmedContent.split(separator: " ")
                    
                    
                    if words.count <= 3 && !isPublic {
                        Button {
                            withAnimation(.default) {
                                self.numberOfShakes += 1
                            }
                            emptyContent = true
                        } label: {
                            Text("Submit")
                                .font(.custom("YoungSerif-Regular", size: 23))
                                .bold()
                                .foregroundColor(Color("Primary"))
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(25)
                                .padding()
                        }
                    } else {
                        Button {
                            if !isPublic {
                                if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    author = "Unknown"
                                }
                                
                                emptyContent = false
                                
                                model.updateData(quoteToUpdate: quote, newContent: content, newAuthor: author, newVisibility: visibility, newColor: color.toHex() ?? "N/A")
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            if isPublic {
                                Image(systemName: "lock")
                            }
                            Text(isPublic ? "This quote is locked - PUBLIC" : "Submit")
                                .bold()
                        }
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding()
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
        }
        
        
    }
    
    
}


