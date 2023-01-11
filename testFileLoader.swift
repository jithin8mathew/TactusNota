////
////  testFileLoader.swift
////  TactusNota
////
////  Created by Jithin  Mathew on 1/9/23.
////
//
//import SwiftUI
//import MobileCoreServices
//
////struct ContentView: View {
////    @State var isShowingPicker = false
////    @State var selectedURL: URL?
////
////    var body: some View {
////        VStack {
////            if selectedURL != nil {
////                Text("Selected folder: \(selectedURL?.lastPathComponent ?? "None")")
////            } else {
////                Button("Select folder") {
////                    self.isShowingPicker = true
////                }
////            }
////        }
////        .sheet(isPresented: $isShowingPicker) {
////            DocumentPickerView(isShowing: self.$isShowingPicker, selectedURL: self.$selectedURL)
////        }
////    }
////}
//
//struct DocumentPickerView: UIViewControllerRepresentable {
//    @Binding var isShowing: Bool
//        @Binding var selectedURL: URL?
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPickerView>) -> UIDocumentPickerViewController {
//        let picker = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
//        picker.allowsMultipleSelection = false
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPickerView>) {
//
//    }
//
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        var parent: DocumentPickerView
//
//        init(_ parent: DocumentPickerView) {
//            self.parent = parent
//        }
//
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//            parent.selectedURL = urls.first
//            parent.isShowing = false
//        }
//    }
//}
