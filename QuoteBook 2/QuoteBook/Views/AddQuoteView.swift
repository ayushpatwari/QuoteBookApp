//
//  AddQuoteView.swift
//  QuoteBook

import SwiftUI

struct AddQuoteView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var model = ViewModel()
    
    @State private var emptyContent: Bool = false
    @State private var numberOfShakes: Int = 0
    let words = ""
    
    @State private var content = ""
    @State private var author = ""
    
    @State private var showingAddView = false
    @State private var isExpanded = false
    @State private var selectedNum = 1
    
    init() {
        UITableView.appearance().contentInset.top = -25
        UITableView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        
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
                            
                            
                            //Add label function 💩
                        }
                        
                        
                        HStack{
                            Image(systemName: "eyedropper")
                            Text("Color")
                            
                            Spacer()
                            
                        }
                        
                    }
                    .cornerRadius(25)
                    .listRowBackground(Color(#colorLiteral(red: 0.9564508796, green: 0.9647257924, blue: 0.9727186561, alpha: 1)))
                }
            }
            .padding()
            
            
            
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
                        
                        model.addData(author: author, content: content)
                        
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
