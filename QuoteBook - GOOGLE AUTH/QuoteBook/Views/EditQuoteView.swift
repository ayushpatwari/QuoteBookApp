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
    @State var quote : Quote
    @State var visibility : Bool
    @State private var isPublic: Bool = false
    
    @State private var emptyContent: Bool = false
    @State private var numberOfShakes: Int = 0
    let words = ""
    
    
    init(quote: Quote){
        self._content = State(initialValue: quote.content)
        self._author = State(initialValue: quote.author)
        self._quote = State(initialValue: quote)
        self._visibility = State(initialValue: quote.visibility)
        self._isPublic = State(initialValue: quote.visibility)
        
        UITableView.appearance().contentInset.top = -25
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Edit quote")
                .bold()
                .font(.title3)
                .offset(x: 0, y: -35)
            Text("Quote")
                .bold()
                .font(.callout)
                .foregroundColor(.gray)
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
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(emptyContent == true ? Color.red : Color.gray))
            .modifier(Shake(animatableData: CGFloat(numberOfShakes)))
            
            if(emptyContent == true){
                Text("Quote is too short")
                    .foregroundColor(.red)
                    .font(.callout)
            }
            
            
            Text("Author")
                .bold()
                .font(.callout)
                .foregroundColor(.gray)
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
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            
            
            
            
            Text("Properties")
                .bold()
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            
            Form{
                Section{
                    
                    HStack{
                        Image(systemName: "tag.fill")
                            .scaleEffect(x: -1, y: 1)
                        Text("Label")
                        
                        //Add label function 💩
                        
                    }
                    
                    HStack{
                        Image(systemName: "eyedropper")
                        Text("Color")
                        
                        Spacer()
                        
                        //Add ColorPicker 💩
                    }
                    
                    HStack{
                        Image(systemName: visibility ? "eye" : "eye.slash")
                        Text(visibility ? "Public" : "Private")
                        
                        Spacer()
                        
                        if isPublic {
                            Toggle("Public", isOn: $isPublic)
                                .disabled(true)
                        } else {
                            Toggle(visibility ? "Public" : "Private", isOn: $visibility)
                        }
                        
                    }
                }
                .cornerRadius(25)
                .listRowBackground(Color(#colorLiteral(red: 0.9564508796, green: 0.9647257924, blue: 0.9727186561, alpha: 1)))
                
            }
            .labelsHidden()
            .frame(maxHeight: .infinity)
            
        }
        .padding()
        
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
                        .bold()
                        .foregroundColor(.white)
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
                        
                        model.updateData(quoteToUpdate: quote, newContent: content, newAuthor: author, newVisibility: visibility)
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
    
    
}


