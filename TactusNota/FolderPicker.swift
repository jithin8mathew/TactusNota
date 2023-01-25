//
//  FolderPicker.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/19/23.
//

// based on the tutorials from
// https://adam.garrett-harris.com/2021-08-21-providing-access-to-directories-in-ios-with-bookmarks/

import SwiftUI

struct FolderPicker: UIViewControllerRepresentable{
    
    @EnvironmentObject private var bookmarkController: BookmarkController
    @Binding var folderContent: String
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let folderPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        folderPicker.delegate = context.coordinator
        return folderPicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, folderContent: $folderContent)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        var parent: FolderPicker
//        var folderContents: String
        
        @Binding var folderContent: String
        
        init(_ parent: FolderPicker, folderContent: Binding<String>) {
            self.parent = parent
            _folderContent = folderContent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.bookmarkController.addBookmark(for: urls[0])
            
            if urls[0].startAccessingSecurityScopedResource(){
                do {
                    print("trying to read contents of directory")
//                    folderContent = try FileManager.default.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
                    try String(contentsOf: urls[0], encoding: .utf8)
                    print("no of files in folder \(folderContent.count)")
                } catch let error{
                    print(error.localizedDescription)
                }
            }
            urls[0].stopAccessingSecurityScopedResource()

        }
        
    }
    
}
