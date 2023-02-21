//
//  ImageDisplayPreview.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 2/18/23.
//

//import Foundation
import SwiftUI

//struct ImageDisplayPreview: UIViewControllerRepresentable{
//
//    let delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
//    let mediaTypes: [String]
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = delegate
//            imagePickerController.sourceType = .photoLibrary
//            imagePickerController.mediaTypes = mediaTypes
//            return imagePickerController
//        }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
//            // Nothing to do here
//        }
//}
struct ImageDisplayPreview: UIViewControllerRepresentable{

    @Binding var currentImageSelection: UIImage
    
    @EnvironmentObject private var model: imageViewModel

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let imageDisplayPreview = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        imageDisplayPreview.delegate = context.coordinator
        return imageDisplayPreview
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, selectedImage: currentImageSelection)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate{

        var parent: ImageDisplayPreview

        init(_ parent: ImageDisplayPreview, selectedImage: UIImage) {
            self.parent = parent
        }

        func imagePicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

            if urls[0].startAccessingSecurityScopedResource(){
                do {
                    let urlsStorage = try FileManager.default.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
                    // currently only supports JPEG and PNG format.
                    let imageFiles = urlsStorage.filter{ $0.pathExtension == "jpg" || $0.pathExtension == "png" }
                    parent.currentImageSelection = UIImage(contentsOfFile: urls[0].path)!
                    } catch let error{
                    print(error.localizedDescription)
                }
            }
            urls[0].stopAccessingSecurityScopedResource()

        }

    }



}
