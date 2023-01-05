//
//  ProjectInfoPage.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/5/23.
//

import SwiftUI

struct ProjectInfoPage: View {
    
    @State private var isAnnotationActive : Bool = false
    @State var projectname: String = "Project 1"
    @State var cName: String = "Car"
    @State var classNameList: [[String]] = []
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
                VStack{ // first vstack
                    Text("New project")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                    Spacer()
                    TextField("Project Name: ", text: $projectname)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .frame(width: 500, height: 50, alignment: .center)
                    HStack{
                        Text("Add class name")
                            .padding()
                            .foregroundColor(.white)
                            .font(.title)
                        
                        TextField("New Class: ", text: $cName)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .frame(width: 500, height: 50, alignment: .center)
                        
                        Button(action: {classNameList.append([cName])}){ // classNameList.append([className])
                            Label("Add", systemImage: "plus.circle")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(50)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: AnnotationView(), isActive: self.$isAnnotationActive) {
                        Button(action: {isAnnotationActive = true}){
                            Label("Next", systemImage: "arrow.forward.circle")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(50)
                        }
                    } // end of navigation link
                    Spacer()
                } // end of first vstack
            } // end of main zstack
        } // end of navigation view
        .navigationViewStyle(StackNavigationViewStyle()) // end of Navigation View// end of navigation view
        .padding(.all, 0)
        
    }
}

struct ProjectInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoPage()
    }
}
