//
//  AnnotationQuickSettingsPopUp.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/22/23.
//

import SwiftUI

struct AnnotationQuickSettingsPopUp: View {
    
    @State public var autoSaveAnnotations = true
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "gear")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding()
                .foregroundColor(.white)
            
            Text("Quick preferences")
                .foregroundColor(.white)
            //                .font(.custom("Playfair Display", fixedSize: 15))
            
            Toggle("Auto Save",isOn: $autoSaveAnnotations)
                .font(.title)
                .foregroundColor(.white)
                .padding(20)
            
            Text("Toggle grid for image")
                .foregroundColor(.white)
            // https://developer.apple.com/videos/play/wwdc2020/10107/
            Text("Use apple pencil toogle or draw with finger toggle, ture by default")
                .foregroundColor(.white)
            Text("Use apple pencil and renderbounds to draw bounding box")
                .foregroundColor(.white)
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
        
    }
}

struct AnnotationQuickSettingsPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationQuickSettingsPopUp()
    }
}
