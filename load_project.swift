//
//  load_project.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 11/8/22.
//

import SwiftUI
import Foundation

struct load_project: View {
    
    @State private var isActive : Bool = false
    @State private var isSettingsActive: Bool = false
    @State private var isProjectInfoActive : Bool = false
    
    var body: some View {
                
//        NavigationView{
            ZStack{
                GeometryReader { geometry in
//                    Color(red: 0.91, green: 0.70, blue: 0.39) // creamish brown (Sun ray)
                    Color(red: 0.0, green: 0.42, blue: 0.51) // Teal blue

                        .ignoresSafeArea()
                    HStack{
                        Spacer()
                        NavigationLink(destination: TNAnnotationSettings(), isActive: self.$isSettingsActive) {
                            Button(action: {self.isSettingsActive = true}, label: {
                                VStack{
                                    Image(systemName: "gear")
                                        .resizable()
                                        .frame(width: 45 + (geometry.size.width * 0.01), height: 40 + (geometry.size.height * 0.01), alignment: .center)
                                        .padding(.top,0)
                                        .padding(.trailing, 10)
                                        .foregroundColor(.white)
                                }
                            })
                        }
                    }
                    VStack(){
                        Spacer()
                        Text("Tacus Nota")
                            .frame(alignment: .center)
                            .font(.custom("Roberta", fixedSize: geometry.size.width * 0.1))
                            .foregroundColor(Color(red: 0.91, green: 0.70, blue: 0.39))
                            .shadow(
                                color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.5),
                                radius: 8,
                                x: 10,
                                y: 10
                            )
                        
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: ProjectInfoPage(), isActive: self.$isProjectInfoActive) {
                                Button(action: {self.isProjectInfoActive = true}, label: {
                                    VStack{
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding(10)
                                        Text("New project")
                                            .font(.system(size: 14))
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 80 + (geometry.size.width * 0.01), height: 60 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(Color(red: 0.33, green: 0.28, blue: 0.44))
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(                    Color(red:1.0, green: 0.4, blue: 0.38))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.4),
                                            radius: 8,
                                            x: 0,
                                            y: 0
                                        )
                                        .padding(-50)
                                )
                                
                            }
                            Spacer()
                            Spacer()
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    VStack{
                                        Image(systemName: "folder")
                                            .resizable()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding(10)
                                        Text("Open project")
                                            .font(.system(size: 14))
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 80 + (geometry.size.width * 0.01), height: 60 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(Color(red: 0.33, green: 0.28, blue: 0.44))
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red:1.0, green: 0.4, blue: 0.38))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.4),
                                            radius: 8,
                                            x: 0,
                                            y: 0
                                        )
                                        .padding(-50)
                                )
                            }
                            Spacer()
                        } // end of first row H-stack
                        .padding(50)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        // second row of icons
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    VStack{
                                        Image(systemName: "squareshape.controlhandles.on.squareshape.controlhandles")
                                            .resizable()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding(10)
                                        Text("Detection")
                                            .font(.system(size: 14))
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 80 + (geometry.size.width * 0.01), height: 60 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(Color(red: 0.33, green: 0.28, blue: 0.44))
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red:1.0, green: 0.4, blue: 0.38))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.4),
                                            radius: 8,
                                            x: 0,
                                            y: 0
                                        )
                                        .padding(-50)
                                )
                            }
                            Spacer()
                            Spacer()
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    VStack{
                                        Image(systemName: "photo")
                                            .resizable()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding(10)
                                        Text("Classification")
                                            .font(.system(size: 14))
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 80 + (geometry.size.width * 0.01), height: 60 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(Color(red: 0.33, green: 0.28, blue: 0.44))
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red:1.0, green: 0.4, blue: 0.38))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.4),
                                            radius: 8,
                                            x: 0,
                                            y: 0
                                        )
                                        .padding(-50)
                                )
                            }
                            Spacer()
                        } // end of second row Hstack
                        .padding(50)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        Spacer()
                    }// vstack 1 end
                    .padding(50)
                } // end of geometry reader
            } // end of zstack 1
//        }// end of nav_view
//        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct load_project_Previews: PreviewProvider {
    static var previews: some View {
        load_project()
    }
}
