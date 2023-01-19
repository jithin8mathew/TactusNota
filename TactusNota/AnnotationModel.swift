////
////  AnnotationModel.swift
////  TactusNota
////
////  Created by Jithin  Mathew on 12/1/22.
////
//
//import Foundation
//
//class AnnotationModel: ObservableObject {
//    
//    @Published var items: [Item] = []
//
//    init() {
//        let documentDirectoryURL = getDocumentsDirectory()
//        do {
//            let files = try FileManager.default.contentsOfDirectory(atPath: "/Users/username/Documents/Photos")
//
//            print(files)
//        } catch {
//            print(error)
//        }
////        if let documentDirectory = FileManager.default.documentDirectory {
////         if let urls = FileManager.contentsOfDirectory(documentDirectoryURL).filter { $0.isImage }
////            for url in urls {
////                let item = Item(url: url)
////                items.append(item)
////            }
////        }
//
//        if let urls = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: nil) {
//            for url in urls {
//                let item = Item(url: url)
//                items.append(item)
//            }
//        }
//    }
//    func addItem(_ item: Item) {
//        items.insert(item, at: 0)
//    }
//
//    /// Removes an item from the data collection.
////    func removeItem(_ item: Item) {
////        if let index = items.firstIndex(of: item) {
////            items.remove(at: index)
////            FileManager.default.removeItemFromDocumentDirectory(url: item.url)
////        }
////    }
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
//
//}
//
//extension URL {
//    var isImage: Bool {
//        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
//        return imageExtensions.contains(self.pathExtension)
//    }
//}
