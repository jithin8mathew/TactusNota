//
//  BookmarkController.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/19/23.
//

import SwiftUI

class BookmarkController: ObservableObject {
    @Published var urls: [URL] = []
    
    // experimental
    @Published var fileURLs: [URL] = []
    
    func addBookmark(for url: URL) {
        do {
            // Start accessing a security-scoped resource.
            guard url.startAccessingSecurityScopedResource() else {
                // Handle the failure here.
                return
            }
            
            // Make sure you release the security-scoped resource when you finish.
            defer { url.stopAccessingSecurityScopedResource() }
            
            // Generate a UUID
            let uuid = UUID().uuidString
            
            // Convert URL to bookmark
            let bookmarkData = try url.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
            // Save the bookmark into a file (the name of the file is the UUID)
            try bookmarkData.write(to: getAppSandboxDirectory().appendingPathComponent(uuid))
            
            // Add the URL and UUID to the urls array
            withAnimation {
                urls.append(url)
            }
        }
        catch {
            // Handle the error here.
            print("Error creating the bookmark")
        }
    }
    
//    func addFileBookmark(for urlF: URL) {
//        do {
//            // Start accessing a security-scoped resource.
//            guard urlF.startAccessingSecurityScopedResource() else {
//                // Handle the failure here.
//                return
//            }
//            // Make sure you release the security-scoped resource when you finish.
//            defer { urlF.stopAccessingSecurityScopedResource() }
//
//            // Generate a UUID
//            let uuidFiles = UUID().uuidString
//
//            // Convert URL to bookmark
//            let bookmarkFileData = try urlF.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
//            // Save the bookmark into a file (the name of the file is the UUID)
//            try bookmarkFileData.write(to: getAppSandboxDirectory().appendingPathComponent(uuidFiles))
//
//            // Add the URL and UUID to the urls array
//            withAnimation {
//                fileURLs.append(urlF)
//            }
//            print("file url count",fileURLs.count)
//        }
//        catch {
//            // Handle the error here.
//            print("Error creating the bookmark")
//        }
//    }

    
    private func getAppSandboxDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
