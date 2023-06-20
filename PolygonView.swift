//import SwiftUI
//import PencilKit
//
//struct DrawingView: UIViewRepresentable {
//    @Binding var canvasView: PKCanvasView
//
//    func makeUIView(context: Context) -> PKCanvasView {
//        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
//        canvasView.drawingPolicy = .anyInput
////
////        if let window = UIApplication.shared.windows.first, let toolPicker = PKToolPicker.shared(for: window) {
////            toolPicker.setVisible(true, forFirstResponder: canvasView)
////            toolPicker.addObserver(canvasView)
////            canvasView.becomeFirstResponder()
////        }
//        return canvasView
//    }
//
//    func updateUIView(_ uiView: PKCanvasView, context: Context) {
//    }
//}
//
//extension CGPoint {
//    var length: CGFloat { sqrt(x * x + y * y) }
//
//    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
//        return CGPoint(x: left.x - right.x, y: left.y - right.y)
//    }
//
//    func distance(to other: CGPoint) -> CGFloat {
//        return (self - other).length
//    }
//}
//
//extension PKStroke {
//    func discreteFrechetDistance(to strokeB: PKStroke, maxThreshold: CGFloat) -> CGFloat {
//        // Convert both stroke paths into an array of a max of 50 CGPoints.
//        let maxPointCount: CGFloat = 50
//        let minParametricStep: CGFloat = 0.2
//        let stepSizeA = max(CGFloat(path.count) / maxPointCount, minParametricStep)
//        let pathA = path.interpolatedPoints(by: .parametricStep(stepSizeA)).map {
//            $0.location.applying(transform)
//        }
//        let stepSizeB = max(CGFloat(strokeB.path.count) / maxPointCount, minParametricStep)
//        let pathB = strokeB.path.interpolatedPoints(by: .parametricStep(stepSizeB)).map { $0.location.applying(strokeB.transform) }
//
//        // Compute the discrete Fréchet distance.
//        let countA = pathA.count
//        let countB = pathB.count
//        guard countA > 0 && countB > 0 else { return 0 }
//
//        // Use a dictionary, since pruning will eliminate most of the space used in a countA x countB array.
//        var memoizedDFD: [Int: CGFloat] = [:]
//
//        func recursiveDFD(indexA: Int, indexB: Int, maxThreshold: CGFloat) -> CGFloat {
//            let memoizedIndex = indexA + countA * indexB
//            // Check that the value has not already been solved.
//            if let existingResult = memoizedDFD[memoizedIndex] {
//                return existingResult
//            }
//
//            let result: CGFloat
//
//            let pointPairDistance = pathA[indexA].distance(to: pathB[indexB])
//            if indexA == 0 && indexB == 0 {
//                // If just checking the first two points, the cost is the distance between the points.
//                result = pointPairDistance
//            } else if pointPairDistance > maxThreshold {
//                // Exit early if this value will never be used, this prunes the search tree.
//                result = pointPairDistance
//            } else if indexB == 0 {
//                // If at the start of path B, move towards the start of path A.
//                result = Swift.max(recursiveDFD(indexA: indexA - 1, indexB: 0, maxThreshold: maxThreshold), pointPairDistance)
//            } else if indexA == 0 {
//                // If at the start of path A, move towards the start of path B.
//                result = Swift.max(recursiveDFD(indexA: 0, indexB: indexB - 1, maxThreshold: maxThreshold), pointPairDistance)
//            } else {
//                // Return the minimum of moving towards the start of A, B, or A & B.
//                let diagonalDFD = recursiveDFD(indexA: indexA - 1, indexB: indexB - 1, maxThreshold: maxThreshold)
//                let leftDFD = recursiveDFD(indexA: indexA - 1, indexB: indexB, maxThreshold: Swift.min(maxThreshold, diagonalDFD))
//                let downDFD = recursiveDFD(indexA: indexA, indexB: indexB - 1, maxThreshold: Swift.min(maxThreshold, leftDFD, diagonalDFD))
//                let minOfRecursion = Swift.min(leftDFD, diagonalDFD, downDFD)
//                result = Swift.max(minOfRecursion, pointPairDistance)
//            }
//
//            memoizedDFD[memoizedIndex] = result
//            return result
//        }
//
//        let frechetDistance = recursiveDFD(indexA: countA - 1, indexB: countB - 1, maxThreshold: maxThreshold)
//        return frechetDistance
//    }
//}
//

import SwiftUI
import PencilKit

class CustomCanvasView: PKCanvasView {
    
    var path: UIBezierPath?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        path = UIBezierPath()
        path?.move(to: touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first, let path = path else { return }
        path.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        path = nil
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        path?.lineWidth = 10
        UIColor.red.setStroke()
        path?.stroke()
    }
}

struct DrawingView: UIViewRepresentable {
    typealias UIViewType = CustomCanvasView
    
    func makeUIView(context: UIViewRepresentableContext<DrawingView>) -> CustomCanvasView {
        let canvasView = CustomCanvasView()
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        return canvasView
    }
    
    func updateUIView(_ uiView: CustomCanvasView, context: UIViewRepresentableContext<DrawingView>) {}
}


struct PolygonView: View {
    @State private var canvasView = PKCanvasView()

    var body: some View {
        DrawingView()
//        DrawingView(canvasView: $canvasView)
    }
}
