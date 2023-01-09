//
//  ProjectInfoPage.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 1/5/23.
//

import SwiftUI

//struct classStruct: Identifiable{
//    let id = Int()
//    var className: String
//}

enum ObjectDetectionType {
    case boundingBox, polygon, line // eventually point
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ProjectInfoPage: View {
    
    @StateObject var classList = ClassList()
    
    @State private var isAnnotationActive : Bool = false
    @State var projectname: String = "Project 1"
    @State var projectpath: String = "path to files"
    @State var cName: String = ""
    @State var classNameList: [String] = []
    @State var checked: Bool = false
//    @State var classNameListReplica: [classStruct]
    
    // display the number of images found in the picked folder
    @State var shouldHideNoImagesButton = false
    @State var imagesFound = false
    
    @State private var odChoice : ObjectDetectionType = .boundingBox // for picking the annotation type
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
                VStack{ // first vstack
                    Text("New project")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                        .foregroundColor(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                        .padding(.top, 100)
                    Spacer()
                    HStack{
                        Text("Project Name")
                            .padding()
                            .padding(.trailing,60)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .background(Color.blue)
                            .cornerRadius(50)
                            .frame(height: 50, alignment: .trailing)
                            .padding(.trailing, -80)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)

                        TextField("Project Name: ", text: $projectname)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                            .cornerRadius(50.0)
                            .frame(width: 500, height: 40, alignment: .center)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        }
                    .frame(alignment: .center)
                    .padding(20)
                    // select project folder
                    HStack{
                        Text("Project Folder")
                            .padding()
                            .padding(.trailing,60)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .background(Color.blue)
                            .cornerRadius(50)
                            .frame(height: 50, alignment: .trailing)
                            .padding(.trailing, -80)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        TextField("Project Folder: ", text: $projectpath)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                .cornerRadius(50.0)
                                .frame(width: 500, height: 50, alignment: .leading)
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            
                            Button(action: {}){
                                Label("folder", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(50)
                                    .frame(height: 50, alignment: .trailing)
                                    .padding(.leading, -115)
                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            }
                    }
                    .frame(alignment: .center)
                    .padding(20)
                    
                    Group{
                        
                        Button(action: {}){
                            Label("images found", systemImage: "photo.stack")
                                .foregroundColor(.white)
                                .padding()
                                .background(imagesFound ? Color.green : Color.red)
                                .cornerRadius(50)
                                .frame(width: 200, height: 10, alignment: .center)
                                .opacity(shouldHideNoImagesButton ? 0 : 1)
                                .font(.footnote)
                            }
                        .padding()
                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        
                        HStack{
                            Picker(selection: $odChoice, label: Text("Bounding box type:")) {
                                Text("Bounding Box").tag(ObjectDetectionType.boundingBox)
                                    .foregroundColor(.white)
                                    .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                    .cornerRadius(50)
                                Text("Polygon").tag(ObjectDetectionType.polygon)
                                    .foregroundColor(.white)
                                    .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                    .cornerRadius(50)
                                Text("Line").tag(ObjectDetectionType.line)
                                    .foregroundColor(.white)
                                    .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                                    .cornerRadius(50)
                            }.pickerStyle(.menu)
                                .frame(maxWidth: 300)
                                .padding(0)
                                .foregroundColor(.white)
                        }
                    }
                    
//                    Group{
//                        if checked {
//                            ZStack{
//                                Circle()
//                                    .fill(Color.blue)
//                                    .frame(width: 20, height: 20)
//                                Circle()
//                                    .fill(Color.white)
//                                    .frame(width: 12, height: 12)
//                            }.onTapGesture {self.checked = false}
//                        } else {
//                            Circle()
//                                .fill(Color.white)
//                                .frame(width: 20, height: 20)
//                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
//                                .onTapGesture {self.checked = true}
//                        }
//                    }
                    
                    HStack{
                        Text("Class")
                            .padding()
                            .padding(.trailing, 30)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .frame(height: 50, alignment: .trailing)
                            .background(Color.blue)
                            .cornerRadius(50)
                            .padding(.trailing, -40)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        
                        TextField("New Class: ", text: $cName)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 1.0, green: 0.68, blue: 0.25, opacity: 1.0))
                            .cornerRadius(50.0, corners: [.topLeft, .bottomLeft])
                            .frame(width: 300, height: 50, alignment: .center)
                            .padding(.trailing,0)
                        
                        Button(action: {
                            if (cName != ""){
                                classList.classNameList.append(cName)
                                cName = ""
                            }
                        }){ // classNameList.append([className])
                            Label("Add", systemImage: "plus.circle")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(50.0, corners: [.topRight, .bottomRight])
                                .padding(.leading, -8)
                                .frame(height: 54)
                        }
                        
                    } // end of add class Hstack
                    .frame(alignment: .center)
                    .padding(20)
                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                    
                    Button(action: {}){ // classNameList.append([className])
                        Label("Import class names", systemImage: "arrow.up.doc.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(50)
                    }
                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                    
                    
                    HStack{
//                        var classCounter = 8
                        ForEach(classList.classNameList , id: \.self) { cls in
//                            classCounter = classCounter + 1
                            Text(cls)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.purple)
                                .cornerRadius(10)
//                            if (classCounter % 8 == 0) {
//                                VStack{}
//                            }
                        }
                    } // end of displaying class list Hstack
                    .frame(width: 700)
                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                    
                    Spacer()
                    NavigationLink(destination: AnnotationView(), isActive: self.$isAnnotationActive) {
                        Button(action: {
                            if (classList.classNameList.count > 0) {
                                isAnnotationActive = true
                            }else{
                                print("enter class names!")
                            }
                        }){
                            Label("Next", systemImage: "arrow.forward.circle")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(50)
                        }
                        .padding(.bottom, 100)
                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                        
                    } // end of navigation link
//                    Spacer()
                } // end of first vstack
            } // end of main zstack
        } // end of navigation view
        .environmentObject(classList)
//        .navigationTitle("Home")
//        .navigationViewStyle(StackNavigationViewStyle()) // end of Navigation View// end of navigation view
        .padding(.all, 0)
        
    }
}

struct ProjectInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        ProjectInfoPage()
    }
}
