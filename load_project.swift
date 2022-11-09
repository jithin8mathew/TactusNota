//
//  load_project.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 11/8/22.
//

import SwiftUI

struct load_project: View {
    
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationView{
                ZStack{
                    GeometryReader { geometry in
                    Color(red: 0.26, green: 0.26, blue: 0.26)
                        .ignoresSafeArea()
                    VStack(spacing: 50){
                        HStack(spacing: 50){
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    Image(systemName: "folder")
                                        .resizable()
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 200, height: 200, alignment: .center)
                            }
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    Image(systemName: "folder")
                                        .resizable()
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 200, height: 200, alignment: .center)
                            }
                        } // hstack 1
                        .padding(50)
                    }// vstack 1
                    .padding(50)
                } // end of geometry reader
            } // end of zstack 1
        }// end of nav_view
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct load_project_Previews: PreviewProvider {
    static var previews: some View {
        load_project()
    }
}
