//
//  AnnotationScreen.swift
//  TactusNota
//
//  Created by Jithin Mathew on 6/20/22.
//

import SwiftUI
import PencilKit

struct AnnotationScreen: View {
    
    @EnvironmentObject var model: AnnotationViewModel
    
    var body: some View {
        ZStack{
            
            CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker)
        }
    }
}

struct AnnotationScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CanvasView: UIViewRepresentable{
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    func makeUIView(context: Context) -> PKCanvasView {

        canvas.isOpaque = true
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if let image = UIImage(data: imageData){
            let imageView = UIImageView(image: image)
//            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
//            let subView2 = canvas.subviews[2]
//            subView.addSubview(customRectangle)
            
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
    }
}

//struct customRectangle:View{
//    @State var viewState = CGSize.zero
//
//    var body: some View {
//            RoundedRectangle(cornerRadius: 30)
//                .fill(Color.blue)
//                .frame(width: 300, height: 400)
//                .offset(x: viewState.width, y: viewState.height)
//                .gesture(
//                    DragGesture().onChanged { value in
//                        viewState = value.translation
//                    }
//                    .onEnded { value in
//                        withAnimation(.spring()) {
//                            viewState = .zero
//                        }
//                    }
//                )
//        }
//}

            
