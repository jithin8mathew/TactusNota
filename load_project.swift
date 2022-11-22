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
                    Image("temp_back")
                        .resizable()
                    HStack{
                        Spacer()
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 55 + (geometry.size.width * 0.01), height: 50 + (geometry.size.height * 0.01), alignment: .center)
                            .padding(20)
                            .foregroundColor(.white)
                    }
                    VStack(){
                        Spacer()
                        Text("Tacus Nota")
                            .frame(alignment: .center)
                            .font(.custom("Roberta", fixedSize: geometry.size.width * 0.1))
                            .foregroundColor(Color(red: 0.26, green: 0.26, blue: 0.26))
                        Spacer()
                        HStack{
                            Spacer()
                            NavigationLink(destination: AnnotationView(), isActive: self.$isActive) {
                                Button(action: {}, label: {
                                    VStack{
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .padding(10)
                                        Text("New project")
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 100 + (geometry.size.width * 0.01), height: 80 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(.yellow)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red: 0.26, green: 0.26, blue: 0.26))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16),
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
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 100 + (geometry.size.width * 0.01), height: 80 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(.yellow)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red: 0.26, green: 0.26, blue: 0.26))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16),
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
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 100 + (geometry.size.width * 0.01), height: 80 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(.yellow)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red: 0.26, green: 0.26, blue: 0.26))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16),
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
                                    }
                                })
                                .shadow(color: Color.black.opacity(0.3),
                                        radius: 3,
                                        x: 3,
                                        y: 3)
                                .frame(width: 100 + (geometry.size.width * 0.01), height: 80 + (geometry.size.height * 0.01), alignment: .center)
                                .foregroundColor(.yellow)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(red: 0.26, green: 0.26, blue: 0.26))
                                        .shadow(
                                            color: Color(red: 0.16, green: 0.16, blue: 0.16),
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
        }// end of nav_view
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct load_project_Previews: PreviewProvider {
    static var previews: some View {
        load_project()
    }
}
