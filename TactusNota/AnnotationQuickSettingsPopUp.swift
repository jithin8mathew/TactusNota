//
//  AnnotationQuickSettingsPopUp.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 3/22/23.
//

import SwiftUI

struct AnnotationQuickSettingsPopUp: View {
    
    @State private var showAnnotationQuickSettingsPopUp = true
    @State public var autoSaveAnnotations = true
    @State private var toggleGrid = false
    @State private var togglePencilOnly = true
    @State private var toggleHoverMark = true
    @State private var toggleDeleteOnSwipe = true
    
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "gear")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .padding()
                .foregroundColor(.white)
            
            Text("Quick preferences")
                .foregroundColor(.white)
            //                .font(.custom("Playfair Display", fixedSize: 15))
            Group{
                // https://www.swiftanytime.com/blog/toggle-in-swiftui
                // turnoff autosave
                Toggle(isOn: $autoSaveAnnotations, label: {
                    Label("Auto Save", systemImage: "filemenu.and.selection")
                })
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(.white)
                .padding()
                
                // turn on grid for each image for easier annotation
                Toggle(isOn: $toggleGrid, label: {
                    Label("Grid", systemImage: "squareshape.split.3x3")
                })
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(.white)
                .padding()
                
                // let user select between apple pencil and finger for annotation
                Toggle(isOn: $togglePencilOnly, label: {
                    Label("Apple Pencil Only", systemImage: "applepencil")
                })
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(.white)
                .padding()
                
                // hover mark used to enhance anntation by hovering the pencil
                Toggle(isOn: $toggleHoverMark, label: {
                    Label("Hover Mark", systemImage: "cursorarrow.rays")
                })
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(.white)
                .padding()
                
                // delete images on swipe up
                Toggle(isOn: $toggleDeleteOnSwipe, label: {
                    Label("Delete On Swipe Up", systemImage: "arrow.up")
                })
                .toggleStyle(SwitchToggleStyle())
                .foregroundColor(.white)
                .padding()
                
            }
            Text("Toggle grid for image")
                .foregroundColor(.white)
            // https://developer.apple.com/videos/play/wwdc2020/10107/
            Text("Use apple pencil toogle or draw with finger toggle, ture by default")
                .foregroundColor(.white)
            Text("Use apple pencil and renderbounds to draw bounding box")
                .foregroundColor(.white)
            HStack{
                Button(action: {
                    showAnnotationQuickSettingsPopUp.toggle()
                }
                ){
                    Label("Close", systemImage: "xmark.circle")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(50.0)
                        .padding(.leading, -8)
                        .frame(height: 54)
                }
                
            } // end of button Hstack
            .padding()
            .shadow(color: Color(red: 0.36, green: 0.36, blue: 0.36), radius: 8, x: 5, y: 5)
            
        } // End of Vstack
        .padding(.all, 10)
        .multilineTextAlignment(.center)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .pink, .red]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10)
        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 15, x: 5, y: 5)
        .frame(minWidth: 400, maxWidth: 850, minHeight: 700, maxHeight: 1600)
        
    }
}

struct AnnotationQuickSettingsPopUp_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationQuickSettingsPopUp()
    }
}
