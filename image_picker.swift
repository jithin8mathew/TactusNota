import SwiftUI


struct image_picker: View {
    
    @State private var fileContent = "" // change to scalar if it didnt work
    @State private var showDocumentPicker = false
    
    
    var body: some View {
        VStack{
        Button("Choose Folder") {
            showDocumentPicker = true
            
//            self.selectFolder()
            
        }
            Text(fileContent)
    }
        .sheet(isPresented: self.$showDocumentPicker){
            filePicker(fileContent: $fileContent)
        }
    }
        
}

//struct DocumentPicker: UIViewControllerRepresentable{
//
//    @Binding var fileContent: String
//
//    func makeCoordinator() -> DocumentPickerCoordinator {
//        return DocumentPickerCoordinator(fileContent: $fileContent)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController{
//        let controller: UIDocumentPickerViewController
//
//        controller.delegate = context.coordinator
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
//    }
//
//
//}

//class DocumentPickerController: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate{
//
//    @Binding var fileContent: String
//
//    init(fileContent: Binding<String>){
//        _fileContent = fileContent
//    }
//
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        let fileURL = urls[0]
//        do {
//            fileContent = try String(contentsOf: fileURL, encoding: .utf8)
//        } catch let error{
//            print(error.localizedDescription)
//        }
//    }
//
//}

struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}
