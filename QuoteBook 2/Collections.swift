//
//  ContentView.swift
//  QuoteBookApp
//
//  Created by Ayush Patwari on 6/28/23.
//

import SwiftUI



struct ContentView: View {
    @State private var text = ""
    @AppStorage("KEY") var savedText = ""
    let uiscreen = UIScreen.main.bounds
    
    var collectionCount = 0
    
    var body: some View {
    
        ZStack{
            VStack(alignment: .center) {
                //title
                Text("Collections")
                    .padding(.bottom)
                    .fontWeight(.semibold)
                    
                
                //main collections
                Grid {
                    GridRow {
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()

                    }
                    GridRow {
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()

                    }
                    GridRow {
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()
                        Text("Box 1")
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .frame(width: 155, height: 155)
                            .background(
                                Rectangle()
                                    .foregroundColor(Color("Color"))
                                    .opacity(0.3)
                                    .cornerRadius(25)
                                    .blur(radius: 1))
                            .padding()

                    }
                    GridRow {
                        Button() {
                        } label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 65, height: 65, alignment: .trailing)
                        }
                    }
                    .gridCellColumns(2)
                    .gridCellAnchor(.trailing)
                    .padding(.trailing, 38.0)
                }
                .padding()
                Spacer()
                
                //nav bar
                HStack {
                    Text("Nav bar")
                }
            }
            .frame(width: self.uiscreen.width, alignment: .center)
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
