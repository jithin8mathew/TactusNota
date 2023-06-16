import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        canvasView.drawingPolicy = .anyInput
//        
//        if let window = UIApplication.shared.windows.first, let toolPicker = PKToolPicker.shared(for: window) {
//            toolPicker.setVisible(true, forFirstResponder: canvasView)
//            toolPicker.addObserver(canvasView)
//            canvasView.becomeFirstResponder()
//        }
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

struct PolygonView: View {
    @State private var canvasView = PKCanvasView()

    var body: some View {
        DrawingView(canvasView: $canvasView)
    }
}
