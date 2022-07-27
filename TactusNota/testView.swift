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
    @State var location = CGPoint.zero

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
            .frame(width: viewState.width + 10, height: viewState.height + 10)
//            .offset(x: viewState.width, y: viewState.height)
            .position(x: location.x , y: location.y )
            .gesture(
                DragGesture().onChanged { value in
                    viewState = value.translation
                    self.location = value.location
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        viewState = value.translation
                    }
                }
            )
            
        Text("Location: (\(location.x), \(location.y))")
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
