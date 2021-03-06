//
//  ImagePicker.swift
//  TactusNota
//
//  Created by Jithin Mathew on 6/19/22.
//

import SwiftUI
//import UIKit



//struct ImagePicker: UIViewControllerRepresentable {
//
//    @Binding var showPicker: Bool
//    @Binding var imageData: Data
//    @EnvironmentObject private var model : AnnotationViewModel
//
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    func makeCoordinator() -> Coordinator {
//        return ImagePicker.Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let controller = UIImagePickerController()
//        controller.sourceType = sourceType
//        controller.delegate = context.coordinator
//
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//
//    }
//
//    class coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let imageData = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)?.pngData() {
//                parent.imageData = imageData
//                parent.showPicker.toggle()
//            }
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.showPicker.toggle()
//        }
//    }
//
//}


struct ImagePicker: UIViewControllerRepresentable {

    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var model : AnnotationViewModel
    
    @Binding var showPicker: Bool
    @Binding var imageData: Data

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
//        model.imageTest = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}

final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var parent: ImagePicker

    init(_ parent: ImagePicker) {
        self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)?.pngData() {
//            parent.selectedImage = image
            parent.imageData = image
            parent.showPicker.toggle()
        }

        parent.presentationMode.wrappedValue.dismiss()
    }

}






//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker()
//    }
//}
