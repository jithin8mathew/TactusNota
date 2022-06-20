//
//  AnnotationViewModel.swift
//  TactusNota
//
//  Created by Jithin Mathew on 6/19/22.
//

import SwiftUI
import PencilKit

class AnnotationViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
    
    @Published var canvas = PKCanvasView()
    @Published  var toolPicker = PKToolPicker()
    
    
}

