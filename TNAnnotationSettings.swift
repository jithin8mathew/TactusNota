//
//  TNAnnotationSettings.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 11/18/22.
//
import SwiftUI

struct TNAnnotationSettings: View {
    @State private var bgColor =
        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.3)
    
    @State private var autoSave = true
    @State private var fixdBboxWidth = false
    @State private var pencilEraser_status = true

    var body: some View {
        ZStack{
            GeometryReader { geometry in
                
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        Toggle("Auto Save",isOn: $autoSave)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                    Toggle("Keep Fixed Bounding Box Width",isOn: $fixdBboxWidth)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                    Toggle("Pencil eraser",isOn: $pencilEraser_status)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                    Spacer()
                    Circle()
                        .foregroundColor(bgColor)
                        .frame(width: 100, height: 100, alignment: .center)
                        .onTapGesture {
                            ColorPicker("Alignment Guides", selection: $bgColor)
                        }
                    ColorPicker("Alignment Guides", selection: $bgColor)
                    Spacer()
                }
            }
        }
    }
}

struct TNAnnotationSettings_Previews: PreviewProvider {
    static var previews: some View {
        TNAnnotationSettings()
    }
}
