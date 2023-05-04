//
//  PolygonView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 5/4/23.
//

import SwiftUI

struct DrawingView: View {
    @GestureState private var dragOffset: CGSize = .zero
    @State private var path = Path()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path(path.cgPath)
                    .stroke(Color.black, lineWidth: 3)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .offset(dragOffset)
            }
            .background(Color.white)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .updating($dragOffset) { value, state, transaction in
                        state = value.translation
                    }
                    .onEnded { value in
                        let location = CGPoint(x: value.location.x, y: value.location.y)
                        path.addLine(to: location)
                    }
            )
        }
    }
}

struct PolygonView: View {
    var body: some View {
        DrawingView()
            .frame(width: 300, height: 300)
            .border(Color.gray)
    }
}

struct PolygonView_Previews: PreviewProvider {
    static var previews: some View {
        PolygonView()
    }
}
