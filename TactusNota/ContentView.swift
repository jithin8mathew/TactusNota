//
//  ContentView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 1/6/22.
//

// Rule 1: click and drag (dragGesture) to draw the bounding box
// Rule 2: if licked on the corners of a drawn bounding box the rezie the bounding box
// Rule 3: If long pressed, then select the bounding box and then be allowed to moe it.

import SwiftUI

// add stats button to view how much the use has annotated

struct RectData  {
    let x: Double
    let y: Double
    let width: Double
    let height: Double
}

struct RectDataDict{
    let ID: Int
    let rectCords: [CGFloat]
}

var bboxID = 0

struct ContentView: View {
    
//    @State var viewState = CGSize.zero
//    @State private var isActive : Bool = false
//    @State private var isActiveTestView : Bool = false
//    @State private var isActiveAnnotationView : Bool = false
//    @State private var isActiveLP : Bool = false
////    @State var points:[CGPoint] = [CGPoint(x:0,y:0), CGPoint(x:50,y:50)]
////
////    @State var position:CGPoint = CGPoint(x:0,y:0)
//    
//    @StateObject var model = AnnotationViewModel()
//    @StateObject var classList = ClassList()
//    
////    @State var isDragging = false
//    @State var viewState = CGSize.zero
//    @State var location = CGPoint.zero
//    
//    @State var startLoc = CGPoint.zero
//    @State var contWidth = CGFloat.zero
//    @State var contHeight = CGFloat.zero
//    
//    @State var rectData: [[CGFloat]] = []
//    
//    @State var annotationDictionary = [Int:[CGFloat]]() // create a dictionary to ID the bounding box and store its coordinates
    
    @State private var isActive : Bool = false
    @State private var isSettingsActive: Bool = false
    @State private var isProjectInfoActive : Bool = false
    
//    var drag: some Gesture {
//            DragGesture()
//                .onChanged {
//                    value in //self.isDragging = true
//                    viewState = value.translation
//                    self.location = value.location
//                }
//                .onEnded {
//                    value in //self.isDragging = false
//                    viewState = value.translation
//                }
//        }
    
    var body: some View {
        
        NavigationView{
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
            }
        } // end of navigationView
//        .environmentObject(classList)
        .navigationViewStyle(StackNavigationViewStyle()) // end of Navigation View// end of navigation view
        .padding(.all, 0)
        
    }
    
}

struct Background:UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeUIView(context: UIViewRepresentableContext<Background>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }

    func makeCoordinator() -> Background.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    func updateUIView(_ uiView: UIView,
                       context: UIViewRepresentableContext<Background>) {
    }

}

//func drawAnnotation(X: CGFloat, Y: CGFloat, Width: CGFloat, Height: CGFloat) -> Void{
//    RoundedRectangle(cornerRadius: 5, style: .circular)
//        .path(in: CGRect(
//            x: X,
//            y: Y, //(3.12 * 2),
//            width: Width, //(4.68 * 2),
//            height: Height
//            )
//        )
////        .stroke(Color(red: 6.0, green: 0.78, blue: 0.16))
////    Circle()
////        .fill(.yellow)
////        .frame(width: 15, height: 15)
//////        .position(x: X, y: Y)
////    Circle()
////        .fill(.yellow)
////        .frame(width: 15, height: 15)
//////        .position(x: X + Width, y: Y)
////    Circle()
////        .fill(.yellow)
////        .frame(width: 15, height: 15)
//////        .position(x: X, y: Y + Height)
////    Circle()
////        .fill(.yellow)
////        .frame(width: 15, height: 15)
////        .position(x: X + Width, y: Y + Height)
//
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
