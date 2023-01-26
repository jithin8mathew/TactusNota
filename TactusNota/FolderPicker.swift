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
    @Binding var urlsStorage: [URL]
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let folderPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        folderPicker.delegate = context.coordinator
        return folderPicker
        
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, folderContent: $folderContent, urlsStorage: $urlsStorage)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        var parent: FolderPicker
        //        var folderContents: String
        
        @Binding var folderContent: String
        
        init(_ parent: FolderPicker, folderContent: Binding<String>, urlsStorage: Binding<[URL]>) {
            self.parent = parent
            _folderContent = folderContent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.bookmarkController.addBookmark(for: urls[0])
            
            
            if urls[0].startAccessingSecurityScopedResource(){
                print(urls[0])
                
                do {
                    print("trying to read contents of directory")
                    //                            var urlString: String = urls[0].absoluteString
                    //                    print(urlString)
                    //                            let bookmarkData = try Data(contentsOf: urls[0])
                    //                            print(bookmarkData)
                    //                            print("no of files in folder \(bookmarkData.count)")
                    print("bookmark data complete")
                    //                            let myURL: URL = URL(string: urlString)!
                    let urlsStorage = try FileManager.default.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
                    print("content", urlsStorage)
                    print(urlsStorage.count)
                    //                    folderContent = try String(contentsOf: urls[0])
                    //                    print("no of files in folder \(folderContent.count)")
                } catch let error{
                    print(error.localizedDescription)
                }
            }
            urls[0].stopAccessingSecurityScopedResource()
            
        }
        
        //        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: URL) {
        //            parent.bookmarkController.addBookmark(for: urls)
        //
        //            guard urls.startAccessingSecurityScopedResource() else {
        //                // Handle the failure here.
        //                return
        //            }
        //
        //            defer { urls.stopAccessingSecurityScopedResource() }
        //
        //            // Use file coordination for reading and writing any of the URL’s content.
        //            var error: NSError? = nil
        //            NSFileCoordinator().coordinate(readingItemAt: urls, error: &error) { (urls) in
        //
        //                let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]
        //
        //                print("test 1")
        //                // Get an enumerator for the directory's content.
        //                guard let fileList =
        //                        FileManager.default.enumerator(at: urls, includingPropertiesForKeys: keys)
        //                else {
        //                    Swift.debugPrint("*** Unable to access the contents of \(urls.path) ***\n")
        //                    return
        //                }
        //                print("printing directory contents")
        //                print(fileList)
        //
        //                for case let file as URL in fileList {
        //                    // Start accessing the content's security-scoped URL.
        //                    guard urls.startAccessingSecurityScopedResource() else {
        //                        // Handle the failure here.
        //                        continue
        //                    }
        //
        //                    // Do something with the file here.
        //                    Swift.debugPrint("chosen file: \(file.lastPathComponent)")
        //
        //                    // Make sure you release the security-scoped resource when you finish.
        //                    urls.stopAccessingSecurityScopedResource()
        //                }
        //            }
        //
        //        }
        
    }
    
}
