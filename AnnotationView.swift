//
//  AnnotationView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 9/12/22.
//

import SwiftUI

struct AnnotationView: View {
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    // testing longPress Drag gesture
    @State var isDragging = false
    @State private var offset = CGSize.zero
    
    //     tap gesture vars
    //    @GestureState var isTapped = false
    
    // long press Geusture vars
    @GestureState var press = false
    @State var show = false
    
    var body: some View {
        //        ZStack{
        //            Color(red: 0.26, green: 0.26, blue: 0.26)
        //                .ignoresSafeArea()
        
        //            let tapGesture = DragGesture(minimumDistance: 0)
        //                .updating($isTapped) {_, isTapped, _ in
        //                    isTapped = true
        //                }
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.2)
            .updating($press) { currentState, gestureState, transaction in
                gestureState = currentState
            }
            .onEnded { value in
//                show.toggle()
                print("long press in progress")
            }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
                    rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                    print("drage gesture activated")
                }
            }) // onEnded
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let simultaneously = longPressGesture.simultaneously(with: mainGesture)
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //        } // end of zstack
        return Image("portland")
            .resizable()
            .cornerRadius(20)
            .font(.title)
            .padding(.all, 5)
            .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 15, y: 15)
//            .onTapGesture {
//                print("Tapped")
//            }
            .overlay( ZStack{
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .path(in: CGRect(
                        x: (startLoc.x),
                        y: (startLoc.y),
                        width: contWidth,
                        height: contHeight
                    )
                    )
                    .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
            })
//            .onLongPressGesture(minimumDuration: 0.3){
//                print("long press action performed")
//            }
            .gesture(simultaneously)
    } // end of main body
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
