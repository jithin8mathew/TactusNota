import SwiftUI


struct image_picker: View {

    @State private var fileContent = "" // change to scalar if it didnt work
    @State private var showDocumentPicker = false


    var body: some View {
        VStack{
        Button("Choose Folder") {
            showDocumentPicker = true
            Text(fileContent)
//            self.selectFolder()

        }
//            Text(fileContent)
    }
        .sheet(isPresented: self.$showDocumentPicker){
            filePicker(fileContent: $fileContent)
        }
    }

}


struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}

//struct image_picker: View {
//    @State private var files: [URL] = []
//    @State private var isPickingFolder = false
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                self.isPickingFolder = true
//            }) {
//                Text("Choose Folder")
//            }
//            .sheet(isPresented: $isPickingFolder) {
//                FolderPickerView(selectedFolder: self.$files)
//            }
//            List(files, id: \.self) { file in
//                Text(file.lastPathComponent)
//            }
//        }
//    }
//}
//
//struct FolderPickerView: View {
//    @Binding var selectedFolder: [URL]
//
//    var body: some View {
//        Text("Choose a folder")
//    }
//}
