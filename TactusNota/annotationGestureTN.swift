//
//  annotationGestureTN.swift
//  TactusNota
//
//  Created by Jithin Mathew on 6/20/22.
//

import SwiftUI

struct annotationGestureTN: View {
    
    @State var tapLocation: CGPoint?
    @State var dragLocation: CGPoint?
    @State var points: [CGPoint] = [CGPoint.zero]
    
    @State private var annotations: [AnyView] = []
    
    var body: some View {
        
        let tapDetector = TapGesture()
                    .onEnded {
                        tapLocation = dragLocation
                        guard let point = tapLocation else {
                            return
                        }
                        points.append(point)
                    }
        
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        self.dragLocation = value.location
                    }

        ZStack{
            
            ForEach(points, id: \.x) {point in
                            CreateCircle(location: point)
                        }
            
            Rectangle()
                .fill(Color.clear)
            ForEach(annotations.indices, id: \.self){
                annotations[$0]
            }
        }
        .gesture(dragGesture.sequenced(before: tapDetector))
//        .onTapGesture(count: 2) {
//            annotations.append(AnyView(
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 100, height: 100)
//            ))
//            
//        }
        
    }
}

struct CreateCircle: View {
    

    @State private var currentLocation: CGPoint = CGPoint(x: 100, y: 100)
    
    init(location: CGPoint) {
        currentLocation = location
    }
    
    var body: some View {

        return Circle().fill(Color.red)
            .frame(width: 50, height: 50)
            .position(currentLocation)
    }
}

struct annotationGestureTN_Previews: PreviewProvider {
    static var previews: some View {
        annotationGestureTN()
    }
}
