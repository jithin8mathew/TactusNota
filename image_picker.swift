import SwiftUI


struct image_picker: View {
    
    @State private var fileContent = [] // change to scalar if it didnt work
    @State private var showDocumentPicker = false
    
    
    var body: some View {
        Button("Choose Folder") {
            showDocumentPicker = true
//            self.selectFolder()
            
        }
    }
    
//    func openDocumentPicker() {
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.jpeg, .png])
//        documentPicker.delegate = self
//        documentPicker.modalPresentationStyle = .overFullScreen
//        documentPicker.allowsMultipleSelection = true
//        present(documentPicker, animated: true)
//    }
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        dismiss(animated: true)
//    }
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//    }
//
//    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
//    }
//
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
//        dismiss(animated: true)
//
//        guard url.startAccessingSecurityScopedResource() else {
//            return
//        }
//
//        defer {
//            url.stopAccessingSecurityScopedResource()
//        }
//
//        // Copy the file with FileManager
//    }

    
//    func selectFolder() {
//
//        let folderChooserPoint = CGPoint(x: 0, y: 0)
//        let folderChooserSize = CGSize(width: 500, height: 600)
//        let folderChooserRectangle = CGRect(origin: folderChooserPoint, size: folderChooserSize)
//        let folderPicker = NSOpenPanel(contentRect: folderChooserRectangle, styleMask: .utilityWindow, backing: .buffered, defer: true)
//
//        folderPicker.canChooseDirectories = true
//        folderPicker.canChooseFiles = true
//        folderPicker.allowsMultipleSelection = true
//        folderPicker.canDownloadUbiquitousContents = true
//        folderPicker.canResolveUbiquitousConflicts = true
//
//        folderPicker.begin { response in
//
//            if response == .OK {
//                let pickedFolders = folderPicker.urls
//
//                self.selectedFolder.getFileList(at: pickedFolders)
//            }
//        }
//    }
}

struct DocumentPicker: UIViewControllerRepresentable{
    
    @Binding var fileContent: String
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(fileContent: $fileContent)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController{
        let controller: UIDocumentPickerViewController
        
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    
}

class DocumentPickerController: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate{
    
    @Binding var fileContent: String
    
    init(fileContent: Binding<String>){
        _fileContent = fileContent
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileURL = urls[0]
        do {
            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
}

struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}
