////
////  PolygonView2.swift
////  TactusNota
////
////  Created by Jithin  Mathew on 12/1/23.
////
//
//import SwiftUI
//import PencilKit
//
//struct PolygonView2: View {
//    
//    @State private var drawing = PKDrawing()
//    
//    var body: some View {
//        VStack {
//            PKCanvasView(drawing: $drawing)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.white)
//                .gesture(DragGesture(minimumDistance: 0)
//                    .onChanged { value in
//                        // Handle pencil input
//                        guard value.isPredicted == false else { return }
//                        let touchLocation = value.location
//                        drawing.strokes.append(createStroke(from: touchLocation))
//                    }
//                )
//        }
//    }
//    
//    private func createStroke(from location: CGPoint) -> PKStroke {
//        // Create a PKStroke with a single point at the specified location
//        let strokePoint = PKStrokePoint(location: location, timeOffset: 0, size: CGSize(width: 5, height: 5), opacity: 1, force: 1, azimuth: 0, altitude: 0)
//        let stroke = PKStroke(
//            ink: PKInk(.pen, color: .black),
//            path: PKStrokePath(controlPoints: [strokePoint]),
//            transform: CGAffineTransform.identity
//        )
//        return stroke
//    }
//}
//
//
//struct PolygonView2: PreviewProvider {
//    static var previews: some View {
//        PolygonView2()
//    }
//}
//
