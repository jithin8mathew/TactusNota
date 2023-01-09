//
//  testFileLoader.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/9/23.
//

import SwiftUI
import MobileCoreServices

class FolderPickerDelegate: NSObject, UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
         // Handle the selected folder here
    }
}

struct testFileLoader: View {
    @State private var selectedFolder: URL?
    @State private var folderPickerDelegate = FolderPickerDelegate()

    var body: some View {
        VStack {
            if selectedFolder != nil {
                Text("Selected folder: \(selectedFolder?.lastPathComponent ?? "None")")
            } else {
                Text("No folder selected")
            }

            Button(action: {
                let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
                documentPicker.delegate = folderPickerDelegate
                UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true)
            }) {
                Text("Select a folder")
            }
        }
    }
}
