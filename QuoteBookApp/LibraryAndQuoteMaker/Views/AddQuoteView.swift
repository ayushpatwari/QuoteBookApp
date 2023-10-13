//
//  AddQuoteView.swift
//  QuoteBook
// CREATED BY RITHIK PATWARI

import SwiftUI
import HalfASheet

struct AddQuoteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = LibraryViewModel()
    
    @State private var emptyContent: Bool = false
    @State private var numberOfShakes: Int = 0
    let words = ""
    
    @State private var content = ""
    @State private var author = ""
    @State private var visibility = false
    @State private var isPublic = false
    @State private var tagsIsSelected = true
    @State private var showingTagSelectionView = false
    
    @State private var showingAddView = false
    @State private var isExpanded = false
    @State private var selectedNum = 1
    @State private var color : Color = .clear
    
    init() {
        UITableView.appearance().contentInset.top = -25
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        ZStack{
        VStack (alignment: .leading) {
            HStack{ // for "Create a new quote" and +
                Text("Create new quote")
                    .bold()
                    .multilineTextAlignment(.trailing)
                    .font(.title3)
                
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color(#colorLiteral(red: 0.9489397407, green: 0.9490725398, blue: 0.948897779, alpha: 1)))
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "multiply")
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                    }
                }
                
                
            }
            .padding()
            
            VStack(alignment: .leading){
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
                            ColorPicker("QuoteColorPicker", selection: $color)
                            
                            Spacer()
                            
                        }
                        
                        HStack{
                            Image(systemName: visibility ? "eye" : "eye.slash")
                            
                            Toggle(isOn: $visibility) {
                                Text(visibility ? "Public" : "Private")
                            }
                            
                            
                            Spacer()
                            
                        }
                        
                    }
                    .cornerRadius(25)
                    .listRowBackground(Color(#colorLiteral(red: 0.9564508796, green: 0.9647257924, blue: 0.9727186561, alpha: 1)))
                }
            }
            .padding()
            
            if visibility {
                Text("Note: This quote will be public to everyone - it cannot be made private once published.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                Spacer()
                let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
                let words = trimmedContent.split(separator: " ")
                
                
                if words.count <= 3 {
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
                        if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            author = "Unknown"
                        }
                        
                        emptyContent = false
                        
                        if visibility == true{
                            isPublic = true
                        }
                        
                        model.addData(author: author, content: content, visibility: visibility, color: color.toHex() ?? "N/A")
                        
                        presentationMode.wrappedValue.dismiss()
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
                }
                
                Spacer()
            }
            
        }
            HalfASheet(isPresented: $showingTagSelectionView, title: "Tags (3 per quote)") {
                TagSelectionView()
            }
            .height(.proportional(0.58))
    }
    }
}


struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
                                                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                                              y: 0))
    }
}
