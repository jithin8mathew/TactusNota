//
//  ContentView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 1/6/22.
//

import SwiftUI

// ghp_mcWpwlDSR8Qp4qPx0nyFOYAS_jackD_aXqErtrRS2crtrttnrrtrZ

// add stats button to view how much the use has annotated
// add number of annotations per image as the user annotates

struct RectData  {
    let x: Double
    let y: Double
    let width: Double
    let height: Double
}

struct ContentView: View {
    
//    @State var viewState = CGSize.zero
    @State private var isActive : Bool = false
//    @State var points:[CGPoint] = [CGPoint(x:0,y:0), CGPoint(x:50,y:50)]
//
//    @State var position:CGPoint = CGPoint(x:0,y:0)
    
    @StateObject var model = AnnotationViewModel()
    
//    @State var isDragging = false
    @State var viewState = CGSize.zero
    @State var location = CGPoint.zero
    
    @State var startLoc = CGPoint.zero
    @State var contWidth = CGFloat.zero
    @State var contHeight = CGFloat.zero
    
    @State var rectData: [[CGFloat]] = []
    
    
    var drag: some Gesture {
            DragGesture()
                .onChanged {
                    value in //self.isDragging = true
                    viewState = value.translation
                    self.location = value.location
                }
                .onEnded {
                    value in //self.isDragging = false
                    viewState = value.translation
                }
        }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
            
            VStack{
                HStack{
                    NavigationLink(destination: annotationGestureTN(), isActive: self.$isActive) {
                        Image(systemName: "plus")
                    }
                                        
                    Button(action: {}, label: {
                                            Text("Images")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Save directory")
                                            .font(.system(.title2))
                                            .frame(width: 160, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Previous")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Next")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    Button(action: {
                                        }, label: {
                                            Text("Save")
                                            .font(.system(.title2))
                                            .frame(width: 97, height: 40)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 7)
                                        })
                                        .background(Color.blue)
                                        .cornerRadius(38.5)
                                        .shadow(color: Color.black.opacity(0.3),
                                                radius: 3,
                                                x: 3,
                                                y: 3)
                    
                }
                
                if let ImageFile = UIImage(data: model.imageData){
                    
                    AnnotationScreen()
                        .environmentObject(model)
                
//                    Image(uiImage: ImageFile)
//                        .resizable()
//                        .cornerRadius(20)
//                        .aspectRatio(contentMode: .fit)
//                        .padding(.all, 10)
                       
                    
                }
                else{
                    Button(action: {model.showImagePicker.toggle()},
                           label: {
                        ZStack{
                            Image("test1")
                                .resizable()
                                .cornerRadius(20)
                                .font(.title)
                                .padding(.all, 5)
                                .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 15, y: 15)
                                .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged {
                                        (value) in //print(value.location)
                                        startLoc = value.startLocation
                                        contWidth = value.location.x - startLoc.x
                                        contHeight = value.location.y - startLoc.y
                                    }
                                    .onEnded({
                                        (value) in
                                            print(value.location)
                                        let tempRectData = [startLoc.x, startLoc.y, contWidth, contHeight]
                                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
//                                        print(rectData)
                                        })
                                )
                                .overlay( VStack{
                                    RoundedRectangle(cornerRadius: 5, style: .circular)
                                        .path(in: CGRect(
                                            x: (startLoc.x),
                                            y: (startLoc.y), //(3.12 * 2),
                                            width: contWidth, //(4.68 * 2),
                                            height: contHeight
                                            )
                                        )
                                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                                })
                            
                                ForEach(self.rectData, id:\.self) {cords in
                                    RoundedRectangle(cornerRadius: 5, style: .circular)
                                        .path(in: CGRect(
                                            x: cords[0],
                                            y: cords[1],
                                            width: cords[2],
                                            height: cords[3]
                                            )
                                        )
                                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                                } // end of ForEach
                        }
                    }).padding(.all, 25)
                }
            } // end of vstack
        }
        } // end of zstack
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
