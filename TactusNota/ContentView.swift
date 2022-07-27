//
//  ContentView.swift
//  TactusNota
//
//  Created by Jithin Mathew on 1/6/22.
//

import SwiftUI

// ghp_mcWpwlDSR8Qp4qPx0nyFOYAS_jackD_aXqErtrRS2crtrttnrrtrZ

struct ContentView: View {
    
    @State var viewState = CGSize.zero
    @State private var isActive : Bool = false
    @State var points:[CGPoint] = [CGPoint(x:0,y:0), CGPoint(x:50,y:50)]
    
    @State var position:CGPoint = CGPoint(x:0,y:0)
    
    @StateObject var model = AnnotationViewModel()
    
    @State var isDragging = false
    
    
    var drag: some Gesture {
            DragGesture()
                .onChanged { _ in self.isDragging = true }
                .onEnded { _ in self.isDragging = false }
        }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                    .ignoresSafeArea()
                
//                return ZStack(alignment: .topLeading) {
//                            Background {
//                                   // tappedCallback
//                                   location in
//                                    self.points.append(location)
//                                }
//                                .background(Color.white)
//                            ForEach(self.points.identified(by: \.debugDescription)) {
//                                point in
//                                Color.red
//                                    .frame(width:50, height:50, alignment: .center)
//                                    .offset(CGSize(width: point.x, height: point.y))
//                            }
//                }
            
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
                    
//                    RoundedRectangle(cornerRadius: 30)
//                        .fill(Color.blue)
//                        .frame(width: 300, height: 400)
//                        .offset(x: viewState.width, y: viewState.height)
//                        .gesture(
//                            DragGesture().onChanged { value in
//                                viewState = value.translation
//                            }
//                            .onEnded { value in
//                                withAnimation(.spring()) {
//                                    viewState = .zero
//                                }
//                            }
//                        )
                    
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
                                RoundedRectangle(cornerRadius: 5, style: .circular)
                                        .fill(self.isDragging ? Color.red : Color.blue)
                                        .frame(width: 100, height: 100, alignment: .center)
                                        .gesture(drag)
                                        .position(position)
    //                            .gesture(
    //                                        DragGesture(minimumDistance: 0, coordinateSpace: .global)
    //                                            .onChanged { value in
    //                                              self.position = value.location
    //                                                print(self.position)
    //                                            }
    //                                            .onEnded { _ in
    //                                              self.position = .zero
    //                                                print(self.position)
    //                                            }
    //                                    )
                            
                        }
                         
                    }).padding(.all, 25)
                }
//                Image("test1")
//                    .resizable()
            } // end of vstack
            .sheet(isPresented: $model.showImagePicker, content: {ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)})
            
           

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
