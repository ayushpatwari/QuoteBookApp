//
//  AddQuoteView.swift
//  QuoteBook

import SwiftUI
import HalfASheet
import OmenTextField

struct AddQuoteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = ViewModel()
    
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
    
    init() {
        
        UITableView.appearance().contentInset.top = -25
        UITableView.appearance().backgroundColor = .clear
    
        
    }
    
    
    var body: some View {
        ZStack{
            Color("Primary")
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                HStack{ // for "Create a new quote" and +
                    Text("Create new quote")
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .font(.custom("JosefinSans-Regular", size: 23))

                    
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
                        .font(.custom("JosefinSans-Regular", size: 20))
                    HStack{
                        Image(systemName: "text.quote")
                            .padding(.leading)
                            .opacity(0.5)
                        
                        OmenTextField("Quote", text: $content /*, axis: .vertical 💩*/)
                            .font(.callout)
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
                        
                        OmenTextField("Author", text: $author)
                            .font(.callout)
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

                }
                .padding()

                if visibility {
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
                    
                    
                    if words.count <= 3 {
                        Button {
                            withAnimation(.default) {
                                self.numberOfShakes += 1
                            }
                            emptyContent = true
                        } label: {
                            Text("Submit")
                                .font(.custom("YoungSerif-Regular", size: 23))
                                .foregroundColor(Color("Primary"))
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
                            
                            model.addData(author: author, content: content, visibility: visibility)
                            
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



struct AddQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuoteView()
    }
}
