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
            Text("warning")
            }
            .padding()
            .multilineTextAlignment(.center)
            .background(.purple)
    }
}

struct popupMessage_Previews: PreviewProvider {
    static var previews: some View {
        popupMessage()
    }
}
