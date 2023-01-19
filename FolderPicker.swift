//
//  FolderPicker.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/19/23.
//

import SwiftUI

struct FolderPicker: UIViewControllerRepresentable{
    
    @EnvironmentObject private var bookmarkController: BookmarkController
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let folderPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        folderPicker.delegate = context.coordinator
        return folderPicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        var parent: FolderPicker
        
        init(_ parent: FolderPicker) {
                    self.parent = parent
                }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.bookmarkController.addBookmark(for: urls[0])
        }
        
    }
    
}
