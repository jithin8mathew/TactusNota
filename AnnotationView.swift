//
//  AnnotationView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 9/12/22.
//

import SwiftUI

struct AnnotationView: View {
    
    enum DragState {
        case inactive // boolean variable
        case pressing // boolean variable
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    // testing longPress Drag gesture
    @State var isDragging = false
    @State private var offset = CGSize.zero
    @State var viewState = CGSize.zero
    
    //     tap gesture vars
    //    @GestureState var isTapped = false
    
    // long press Geusture vars
    @GestureState var press = false
    @State var show = false
    //    @GestureState var location = CGPoint(x:0, y:0)
    
    // drag gesture
    @State var isDraggable = false
    @State var translation = CGSize.zero
    
    @GestureState var dragState = DragState.inactive
    @State var boxID = 0
    
    // switch case state value holder
    //    @State var viewState = CGSize.zero
    
    var body: some View {
        //        ZStack{
        //            Color(red: 0.26, green: 0.26, blue: 0.26)
        //                .ignoresSafeArea()
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
            .sequenced(before: DragGesture()) // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-gesture-chains-using-sequencedbefore
            .updating($dragState) { value, gestureState, transaction in
                switch value{
                case .first(true):
                    gestureState = .inactive
//                    for bCords in rectData{
//                        boxID = 0
                        // write a function to check if the values are withing the drawn bbox
                        
//                        boxID = boxID + 1
//                    }
                case .second(true, let drag):
                    gestureState = .dragging(translation: drag?.translation ?? .zero)
                    print("Moving annotation box")
                default:
                    gestureState = .inactive
                }
            }
            .onEnded { value in
                print("long press ended")
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += drag.translation.width
                self.viewState.height += drag.translation.height
            }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation
                checkCoordinates(coordinates: startLoc, coordinateList: rectData)
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
                    rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                    print("Bbox drawn")
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
            .overlay( ZStack{
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .path(in: CGRect(
                        x: (startLoc.x), //+ (viewState.width + dragState.translation.width),
                        y: (startLoc.y), //+ (viewState.height + dragState.translation.height),
                        width: contWidth, //+ (viewState.width + dragState.translation.width),
                        height: contHeight //+ (viewState.height + dragState.translation.height)
                    )
                    )
                    .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                
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
                } // end of for each loop
            }) // end of image overlay and zstack inside it
            .gesture(simultaneously)
    } // end of main body
}

func checkCoordinates(coordinates: CGPoint, coordinateList: [[CGFloat]]){
//    print("function checkCoordinates called")
    bboxID = 0
    for bCord in coordinateList{
        bboxID = bboxID + 1
        if coordinates.x >= bCord[0]  && coordinates.x <= (bCord[0]+bCord[2])  && coordinates.y >= bCord[1] && coordinates.y <= (bCord[1]+bCord[3]) { // && bCord[1]+(bCord[2]+bCord[3]) >= coordinates.y
            print("actual coordinates:", coordinates.x, coordinates.y)
            print("withing bbox",bCord[0],bCord[1], bCord[0]+bCord[2], bCord[1]+bCord[3])
            print(bboxID)
        }
            
        if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            print("within C1 edge...")
        }
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
