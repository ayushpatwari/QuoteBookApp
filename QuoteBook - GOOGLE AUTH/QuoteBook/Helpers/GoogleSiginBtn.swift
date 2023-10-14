//
//  GoogleSiginBtn.swift
//  QuoteBook
//
//  Created by Rajeev Kumar on 8/26/23.
//

import SwiftUI

struct GoogleSiginBtn: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.09948726743, green: 0.582545042, blue: 0.7341625094, alpha: 1)))
                    .cornerRadius(25)
                
                HStack{
                    Image("GoogleLogo")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Text("Continue with Google")
                        .foregroundColor(.black)
                        .font(.custom("JosefinSans-Regular", size: 30))
                        .bold()
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .padding()
        }
    }
}

struct GoogleSiginBtn_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSiginBtn(action: {})
    }
}
