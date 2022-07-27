//
//  testView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 7/27/22.
//

import SwiftUI

//struct testView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct testView: View {
    @State var viewState = CGSize.zero

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
            .frame(width: 300, height: 400)
            .offset(x: viewState.width, y: viewState.height)
            .gesture(
                DragGesture().onChanged { value in
                    viewState = value.translation
                    
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        viewState = .zero
                    }
                }
            )
            .position(x: viewState.height + 200, y: viewState.width + 200)
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
