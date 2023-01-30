//
//  ClassList.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/7/23.
//

import Foundation
import SwiftUI

// this is a class file to pass class and other annotation related data to other views in the app

// EnvironmentObjects
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views

class ClassList: ObservableObject {
    @Published var classNameList: [String] = []
    
    @Published private var image_urls: [URL] = []
}

