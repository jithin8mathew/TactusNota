//
//  FileController.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/25/23.
//

import Foundation

class FileController: ObservableObject {
    func getContentsOfDirectory(url: URL) -> [URL] {
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch {
            print(error)
            return []
        }
    }
}
