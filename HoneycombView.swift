////
////  HoneycombView.swift
////  TactusNota
////
////  Created by Jithin  Mathew on 12/26/22.
////
//
//import SwiftUI
//
//struct HoneycombView: View {
//    // The number of rows and columns in the honeycomb pattern
//    let rows: Int
//    let columns: Int
//    
//    // The size of each hexagon cell in the honeycomb pattern
//    let cellSize: CGFloat
//    
//    var body: some View {
//        ZStack {
//            ForEach(0..<rows, id: \.self) { row in
//                HStack(spacing: self.cellSize / 2) {
//                    ForEach(0..<self.columns, id: \.self) { column in
//                        // Create a hexagon shape for each cell in the honeycomb pattern
//                        Hexagon(size: self.cellSize)
//                            // Randomly color each cell in the honeycomb pattern
//                            .fill(Color.random())
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct Hexagon: Shape {
//    // The size of the hexagon
//    let size: CGFloat
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        // Calculate the points of the hexagon
//        let pointA = CGPoint(x: rect.midX, y: rect.minY)
//        let pointB = CGPoint(x: rect.maxX, y: rect.midY)
//        let pointC = CGPoint(x: rect.midX, y: rect.maxY)
//        let pointD = CGPoint(x: rect.minX, y: rect.midY)
//        let pointE = CGPoint(x: rect.midX - size / 2, y: rect.minY + size / 4)
//        let pointF = CGPoint(x: rect.midX + size / 2, y: rect.minY + size / 4)
//        
//        // Create the path for the hexagon
//        path.move(to: pointA)
//        path.addLine(to: pointB)
//        path.addLine(to: pointC)
//        path.addLine(to: pointD)
//        path.addLine(to: pointE)
//        path.addLine(to: pointA)
//        path.addLine(to: pointF)
//        path.addLine(to: pointC)
//        
//        return path
//    }
//}
//
//extension Color {
//    static func random() -> Color {
//        return Color(red: .random(in: 0...1),
//                     green: .random(in: 0...1),
//                     blue: .random(in: 0...1))
//    }
//}
//
//struct HoneycombView: PreviewProvider {
//    static var previews: some View {
//        HoneycombView(10,10,5)
//    }
//}
