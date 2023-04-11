//
//  FolderPicker.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/19/23.
//

// based on the tutorials from
// https://adam.garrett-harris.com/2021-08-21-providing-access-to-directories-in-ios-with-bookmarks/

// more tutorials at : https://benscheirman.com/2019/10/troubleshooting-appkit-file-permissions/
// Official documentation at :  https://developer.apple.com/documentation/uikit/view_controllers/providing_access_to_directories

import SwiftUI

struct FolderPicker: UIViewControllerRepresentable{
    
    @EnvironmentObject private var bookmarkController: BookmarkController
    @EnvironmentObject private var fileBookmarkController: FileBookmarkController
    @EnvironmentObject private var imageBookmarkController: ImageBookmarkController
    @Binding var folderContent: String
    @Binding var urlsStorageTest: [URL]
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let folderPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.folder])
        folderPicker.delegate = context.coordinator
        return folderPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, folderContent: $folderContent, urlsStorage: $urlsStorageTest)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate{
        
        var parent: FolderPicker
        
        @Binding var folderContent: String
        
        init(_ parent: FolderPicker, folderContent: Binding<String>, urlsStorage: Binding<[URL]>) {
            self.parent = parent
            _folderContent = folderContent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.bookmarkController.addBookmark(for: urls[0])
            
            if urls[0].startAccessingSecurityScopedResource(){
                do {
                    let urlsStorage = try FileManager.default.contentsOfDirectory(at: urls[0], includingPropertiesForKeys: nil)
                    // currently only supports JPEG and PNG format.
                    let imageFiles = urlsStorage.filter{ $0.pathExtension == "jpg" || $0.pathExtension == "png" }
//                    parent.urlsStorageTest = imageFiles
                    
                    // Experimental
                    // Creating a new image file (do this in loop to create multiple image files in app's sandbox directory)
//                    https://stackoverflow.com/questions/54013155/swift-how-to-copy-files-from-app-bundle-to-documents-folder-when-app-runs-for-f
                    guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        return
                    }
                    for imageFile in imageFiles{
                        let newFileUrl = documentsDirectoryUrl.appendingPathComponent(imageFile.lastPathComponent) // imageFileList[0].

                        if !FileManager.default.fileExists(atPath: newFileUrl.path) {
                            FileManager.default.createFile(atPath: newFileUrl.path, contents: nil, attributes: nil)
                        }
                        
                        // repeat this for all images in the directory using loop
                        if let resourceData = try? Data(contentsOf: imageFiles[0]), let fileHandle = try? FileHandle(forWritingTo: newFileUrl) {
                            defer {
                                fileHandle.closeFile()
                            }
                            fileHandle.write(resourceData)
                        }
                        parent.urlsStorageTest.append(newFileUrl)

                    } // end of experimental for loop
//                    let newFileUrl = documentsDirectoryUrl.appendingPathComponent(imageFiles[0].lastPathComponent) // imageFileList[0].
//
//                    if !FileManager.default.fileExists(atPath: newFileUrl.path) {
//                        FileManager.default.createFile(atPath: newFileUrl.path, contents: nil, attributes: nil)
//                    }
//
//                    // repeat this for all images in the directory using loop
//                    if let resourceData = try? Data(contentsOf: imageFiles[0]), let fileHandle = try? FileHandle(forWritingTo: newFileUrl) {
//                        defer {
//                            fileHandle.closeFile()
//                        }
//                        fileHandle.write(resourceData)
//                    }
//                    parent.urlsStorageTest = [newFileUrl] // this needs to be edited to pass image list from app's sandbox directory.

                    
                    // End of experimentall
                    
//                    for imgURL in imageFiles{
//                        ImageBookmarkController.addBookmark(for: imgURL)
//                    }
//                    ImageBookmarkController.addBookmark(for: imageFiles) // Use foreach loop here
//                    print(urlsStorage.count)
//                    print(imageFiles.count)
                } catch let error{
                    print(error.localizedDescription)
                }
            }
            urls[0].stopAccessingSecurityScopedResource()
            
        }
        
    }
    
}
