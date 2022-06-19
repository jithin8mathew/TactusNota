//
//  AnnotationViewModel.swift
//  TactusNota
//
//  Created by Jithin Mathew on 6/19/22.
//

import SwiftUI

class AnnotationViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
}

