import SwiftUI

struct image_picker: View {
    
    var body: some View {
        Button("Choose Folder") {
//            self.selectFolder()
        }
    }
    
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

struct image_picker_Previews: PreviewProvider {
    static var previews: some View {
        image_picker()
    }
}
