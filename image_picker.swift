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


struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}
