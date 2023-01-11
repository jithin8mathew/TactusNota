//
//  filePicker.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 11/11/22.
//
import SwiftUI

struct filePicker: UIViewControllerRepresentable{

    @Binding var fileContent: String
    
    // Experimental
    let fileManager = FileManager.default

    func makeCoordinator() -> filePickerCoordinator {
        return filePickerCoordinator(fileContent: $fileContent)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<filePicker>) -> UIDocumentPickerViewController{
        let controller: UIDocumentPickerViewController

        if #available(iOS 14, *) {
            controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text], asCopy: true)
        } else {
            controller = UIDocumentPickerViewController(documentTypes: [String(kUnknownType)], in: .import)
        }
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<filePicker>) {
    }


}

class filePickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate{
    
    @Binding var fileContent: String
    
    init(fileContent: Binding<String>){
        _fileContent = fileContent
    }
    
    func filePicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileURL = urls[0]
//        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
//            let items = try FileManager.contentsOfDirectory(at :directoryURL)
//            for item in items {
//                    print("Found \(item)")
//                }
//            print(urls)
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
}


//struct DocumentPickerViewController: UIViewControllerRepresentable {
//    typealias UIViewControllerType = UIDocumentPickerViewController
//
//    var documentTypes: [String]
//    var onDocumentPicked: (URL) -> Void
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPickerViewController>) -> UIDocumentPickerViewController {
//        let controller = UIDocumentPickerViewController(documentTypes: documentTypes, in: .open)
//        controller.delegate = context.coordinator
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPickerViewController>) {
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(onDocumentPicked: onDocumentPicked)
//    }
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var onDocumentPicked: (URL) -> Void
//
//        init(onDocumentPicked: @escaping (URL) -> Void) {
//            self.onDocumentPicked = onDocumentPicked
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            onDocumentPicked(urls[0])
//        }
//    }
//}


