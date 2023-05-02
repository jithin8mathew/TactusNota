//
//  display_annotations.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 5/2/23.
//

import SwiftUI

struct display_annotations: View {
    
    @Binding var annotationFileContent: String
    
    var body: some View {
        Text(annotationFileContent)
    }
}

