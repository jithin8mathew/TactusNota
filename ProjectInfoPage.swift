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
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{ // first vstack
                    Text("New project")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                    
                    TextField("Project Name: ", text: $projectname)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    NavigationLink(destination: AnnotationView(), isActive: self.$isAnnotationActive) {
                        Button(action: {isAnnotationActive == true}){
                            Label("Next", systemImage: "arrow.forward.circle")
                        }
                    } // end of navigation link
                } // end of first vstack
            } // end of main zstack
        } // end of navigation view 
        
    }
}

struct ProjectInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoPage()
    }
}
