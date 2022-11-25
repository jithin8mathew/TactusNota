//
//  filePicker.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 11/11/22.
//
import SwiftUI

struct filePicker: UIViewControllerRepresentable{

    @Binding var fileContent: String

    func makeCoordinator() -> filePickerCoordinator {
        return filePickerCoordinator(fileContent: $fileContent)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<filePicker>) -> UIDocumentPickerViewController{
        let controller: UIDocumentPickerViewController

        if #available(iOS 14, *) {
            controller = UIDocumentPickerViewController(forOpeningContentTypes: [.png, .jpeg], asCopy: true)
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
        do {
            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            print(urls)
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
}

