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
    @State private var isPloygonViewActive : Bool = false
    
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
//                HoverPointer()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                GeometryReader { geometry in
                    //                    Color(red: 0.91, green: 0.70, blue: 0.39) // creamish brown (Sun ray)
                    //                    Color(red: 0.0, green: 0.42, blue: 0.51) // Teal blue
                    //                    Color(red: 0.21, green: 0.35, blue: 0.42) // pacific blue
//                    Color(red: 1.0, green: 1.0, blue: 1.0) // pacific blue
                    Color(red: 0.07, green: 0.13, blue: 0.21) // pacific blue
                        .ignoresSafeArea()
                    VStack{
                        Spacer()
                        Spacer()
                        Image("yellowMushroom")
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                        //                        .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            .foregroundColor(.black)
                        HStack{
                            Spacer()
                            NavigationLink(destination: TNAnnotationSettings(), isActive: self.$isSettingsActive) {
                                Button(action: {self.isSettingsActive = true}, label: {
                                    VStack{
                                        Image(systemName: "gear")
                                            .resizable()
                                            .frame(width: 35 + (geometry.size.width * 0.01), height: 30 + (geometry.size.height * 0.01), alignment: .center)
                                            .padding(.top,10)
                                            .padding(.trailing, 10)
                                            .foregroundColor(.white)
                                    }
                                })
                            }
                        }
                    }
                    VStack(){
                        Spacer()
                        // https://developer.apple.com/documentation/swiftui/applying-custom-fonts-to-text
                        Text("Tacus Nota")
                            .frame(alignment: .center)
                            .font(.custom("Playfair Display", fixedSize: geometry.size.width * 0.1))
                            .foregroundColor(.orange)
                            .shadow(
                                color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.5),
                                radius: 8,
                                x: 10,
                                y: 10
                            )
                        
                        Spacer()
                        
                        Hexagon2()
                            .stroke(.orange, lineWidth: 5.0)
                            .frame(width: 300, height: 300, alignment: .center)
                            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                            .padding(0)
                        
                        Spacer()
                        
                        //                        HStack{
                        //                            Spacer()
                        
                        VStack{
                            
                            NavigationLink(destination: ProjectInfoPage(), isActive: self.$isProjectInfoActive) {
                                Button(action: {
                                    isProjectInfoActive = true
                                }){
                                    Label("New project", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                                        .foregroundColor(.white)
                                        .padding(20)
                                        .padding(.horizontal, 40)
                                        .background(Color.red)
                                        .cornerRadius(50)
                                }
                                .padding(.bottom, 100)
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16, opacity: 0.7), radius: 5, x: 5, y: 5)
                            }
                            
                            HStack{
                                Spacer()
                                NavigationLink(destination: ProjectInfoPage(), isActive: self.$isProjectInfoActive) {
                                    Button(action: {
                                        isProjectInfoActive = true
                                    }){
                                        Label("Open project", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                                            .foregroundColor(.white)
                                            .padding(20)
                                            .padding(.horizontal, 40)
                                            .background(Color.red)
                                            .cornerRadius(50)
                                    }
                                    .padding(.bottom, 100)
                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                }
                                
                            } // end of second row Hstack
                            .padding(50)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            
                            HStack{
                                NavigationLink(destination: PolygonView(), isActive: self.$isPloygonViewActive) {
                                    Button(action: {
                                        isPloygonViewActive = true
                                    }){
                                        Label("Inspection", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                                            .foregroundColor(.white)
                                            .padding(20)
                                            .padding(.horizontal, 40)
                                            .background(Color.red)
                                            .cornerRadius(50)
                                    }
                                    .padding(.bottom, 100)
                                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 5, y: 5)
                                }
                            }
                            Spacer()
                        } // end of first row H-stack
                        .padding(50)
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        
                        //                            Spacer()
                        //                        } // end of second row Hstack
                        //                        .shadow(color: Color.black.opacity(0.3),
                        //                                radius: 3,
                        //                                x: 3,
                        //                                y: 3)
                        //                        Spacer()
                        //                        Spacer()
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

extension UIScreen{
    static let screenWidth_ = UIScreen.main.bounds.size.width
    static let screenHeight_ = UIScreen.main.bounds.size.height
    static let screenSize_ = UIScreen.main.bounds.size
}

struct Hexagon2: Shape {
    func path(in rect: CGRect) -> Path {
        let height = UIScreen.screenHeight_
        //        let width = UIScreen.screenWidth
        
        return Path{path in
            
            let pt1 = CGPoint(x: 50 + (50/(height/2)), y: 173 + (173/(height/2)))
            let pt2 = CGPoint(x: 0, y: 87+(87/(height/2)))
            let pt3 = CGPoint(x: 50 + (50/(height/2)), y:0) // was 10
            let pt4 = CGPoint(x: 150 + (150/(height/2)), y: 0)
            let pt5 = CGPoint(x: 200 + (200/(height/2)), y: 87 + (87/(height/2)))
            let pt6 = CGPoint(x: 150 + (150/(height/2)), y: 173 + (173/(height/2))) // was -10
            
            path.move(to: pt6)
            
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 5)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 5)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 5)
            path.addArc(tangent1End: pt4, tangent2End: pt5, radius: 5)
            path.addArc(tangent1End: pt5, tangent2End: pt6, radius: 5)
            path.addArc(tangent1End: pt6, tangent2End: pt1, radius: 5)
        }
    }
    
}


//struct Hexagon2: Shape {
//    func path(in rect: CGRect) -> Path {
//        let height = UIScreen.screenHeight_
//        print(height) // 1366 for 12.9 inch ipad (200 = 14%, 150 = 10.98%, 50=5.49%, 173=19%, 87=9.55%)
////        let width = UIScreen.screenWidth
//
//        return Path{path in
//
//            let pt1 = CGPoint(x: (height * 0.0549) + ((height * 0.0549)/(height/2)), y: (height * 0.19) + ((height * 0.19)/(height/2)))
//            let pt2 = CGPoint(x: 0, y: (height * 0.0955)+((height * 0.0955)/(height/2)))
//            let pt3 = CGPoint(x: (height * 0.0549) + ((height * 0.0549)/(height/2)), y:0) // was 10
//            let pt4 = CGPoint(x: (height * 0.1098) + ((height * 0.1098)/(height/2)), y: 0)
//            let pt5 = CGPoint(x: (height * 0.14642) + ((height * 0.14642)/(height/2)), y: (height * 0.0955) + ((height * 0.0955)/(height/2)))
//            let pt6 = CGPoint(x: (height * 0.1098) + ((height * 0.1098)/(height/2)), y: (height * 0.19) + ((height * 0.19)/(height/2))) // was -10
//
//            path.move(to: pt6)
//
//            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 5)
//            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 5)
//            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 5)
//            path.addArc(tangent1End: pt4, tangent2End: pt5, radius: 5)
//            path.addArc(tangent1End: pt5, tangent2End: pt6, radius: 5)
//            path.addArc(tangent1End: pt6, tangent2End: pt1, radius: 5)
//        }
//    }
//
//}

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
