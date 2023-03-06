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
            Image(systemName: "gear")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding()
                .foregroundColor(.white)
                
            Text("This is a waarning suggesting that \n the system was not able to load the image \n from the folder selected by the user")
                .foregroundColor(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            .background(.red)
            .cornerRadius(10)
//        Button()
    }
}

struct popupMessage_Previews: PreviewProvider {
    static var previews: some View {
        popupMessage()
    }
}
