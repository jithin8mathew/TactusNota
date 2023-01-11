
// Interesting read
// https://www.appypie.com/filemanager-files-swift-how-to/

import SwiftUI

struct image_picker: View {
    
    @State private var fileContent = "" // change to scalar if it didnt work
    @State private var showDocumentPicker = false
    
    // based on this tutorial https://www.hackingwithswift.com/example-code/system/how-to-read-the-contents-of-a-directory-using-filemanager
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    
    // https://sarunw.com/posts/url-type-properties/
    //    let documentsDirectory = try? FileManager.default.url(
    //        for: .documentDirectory,
    //        in: .userDomainMask,
    //        appropriateFor: nil,
    //        create: false)
    
    
    var body: some View {
        VStack{
            
            Text(fileContent)
                .padding()

            
            Button("Choose Folder") {
                
                //                do {
                //                    let items = try fm.contentsOfDirectory(atPath: path)
                //
                //                    for item in items {
                //                        print("Found \(item)")
                //                        Text("Found \(item)")
                //                    }
                //                } catch {
                //                    // failed to read directory – bad permissions, perhaps?
                //                }
 

                showDocumentPicker = true
 //                self.selectFolder()
                
            }
            //            Text(fileContent)
        }
        .sheet(isPresented: self.$showDocumentPicker){
            filePicker(fileContent: $fileContent)
        }
    } // end of main body
}


struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}


// PICKING FILES FROM AN EXTERNAL USB-C DIRVE

//func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
//        print(urls)
//        self.pickedFolderURL = urls.first!
//}
//
//@IBAction func readFiles(){
//        // Reading the Content of a Picked Folder
//        let shouldStopAccessing = pickedFolderURL.startAccessingSecurityScopedResource()
//        defer {
//            if shouldStopAccessing {
//                pickedFolderURL.stopAccessingSecurityScopedResource()
//            }
//        }
//        var coordinatedError:NSError?
//        NSFileCoordinator().coordinate(readingItemAt: pickedFolderURL, error: &coordinatedError) { (folderURL) in
//            let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]
//            let fileList = FileManager.default.enumerator(at: pickedFolderURL, includingPropertiesForKeys: keys)!
//            logString = ""
//            for case let file as URL in fileList {
//
//                let newFile = file.path.replacingOccurrences(of: pickedFolderURL.path, with: "")
//                if(newFile.hasPrefix("/.") == false){ //exclude hidden
//                    print(file)
//                    logString += "\n\(file)"
//                }
//            }
//            self.logTextView.text = logString
//        }
//    }

