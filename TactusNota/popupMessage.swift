//
//  popupMessage.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/6/23.
//

import SwiftUI

struct popupMessage: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding()
                .foregroundColor(.white)
            
            Text("This is a waarning suggesting that \n the system was not able to load the image \n from the folder selected by the user")
                .foregroundColor(.white)
            //                .font(.custom("Playfair Display", fixedSize: 15))
            
            HStack{
                Button(action: {}
                ){
                    Label("Accept", systemImage: "checkmark.circle")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(50.0, corners: [.topLeft, .bottomLeft])
                        .padding(.leading, -8)
                        .frame(height: 54)
                }
                
                Button(action: {}
                ){
                    Label("Decline", systemImage: "multiply.circle")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(50.0, corners: [.topRight, .bottomRight])
                        .padding(.leading, -8)
                        .frame(height: 54)
                }
            } // end of button Hstack
            .padding()
            .shadow(color: Color(red: 0.36, green: 0.36, blue: 0.36), radius: 8, x: 5, y: 5)
        } // End of Vstack
        .padding()
        .multilineTextAlignment(.center)
        .background(.red)
        .cornerRadius(10)
        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 15, x: 5, y: 5)
        
        //        Button()
    }
}

struct popupMessage_Previews: PreviewProvider {
    static var previews: some View {
        popupMessage()
    }
}
