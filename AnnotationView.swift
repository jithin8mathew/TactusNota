//
//  AnnotationView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 9/12/22.
//

import SwiftUI

class handleBoxControl: ObservableObject{
    @Published var saveCurrentBbox = true
}

// create a @Published to receive current bbox that user is working with for moving and resizing etc
//class GlobalString: ObservableObject{
//    @Published var currentBoxID = Int()
//}

struct AnnotationView: View {
    
//    @StateObject var globalString = GlobalString()
    @EnvironmentObject var statusUpdate: handleBoxControl
    
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
        
//        var isActive: Bool {
//            switch self {
//            case .inactive:
//                return false
//            case .pressing, .dragging:
//                return true
//            }
//        }

        var isActive: Bool {
            switch self {
            case .inactive, .dragging:
                return false
            case .pressing:
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
        
//        var isPressDragging: Bool{
//            switch self{
//            case .inactive:
//                return false
//            case .dragging, .pressing:
//                return true
//            }
//        }
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
//    @State var pressDrag = false
    //    @GestureState var location = CGPoint(x:0, y:0)
    
    // drag gesture
    @State var isDraggable = false
    @State var translation = CGSize.zero
    
    @GestureState var dragState = DragState.inactive
    @State var boxID = 0
    
    // becomes ture if the user raps or drags within the bounding box
    @State var withingBBox = false
    // Trun this update on or off to prevent bounding box from being drawn when the user is dragging an existing bbox
    @State var RTdrawState = true
    
    @State var testButton = false
    
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
                case .second(true, let drag):
                    gestureState = .dragging(translation: drag?.translation ?? .zero)
//                    testButton = true // modifying state var here wont work
//                    rectData[globalString.currentBoxID] = [startLoc.x + (drag?.translation.width ?? .zero), startLoc.y + (drag?.translation.height ?? .zero), contWidth, contHeight]
//                    print("long press update values :", startLoc.x + (drag?.translation.width ?? .zero), startLoc.y + (drag?.translation.height ?? .zero), contWidth, contHeight)
                default:
//                    pressDrag = false // testing
                    gestureState = .inactive
                }
            }
            .onEnded { value in
                print("long press ended")
                guard case .second(true, let drag?) = value else { return }
                self.viewState.width += drag.translation.width
                self.viewState.height += drag.translation.height
                print("currentString ID ",bboxID) // this shows that current string ID is not updating
                print("rectData before change : ",rectData[bboxID-1])
            
//                rectData[globalString.currentBoxID][0] += drag.translation.width
//                rectData[globalString.currentBoxID][1] += drag.translation.height
                rectData[bboxID][0] += drag.translation.width
                rectData[bboxID][1] += drag.translation.height
                print(drag.translation.width, drag.translation.height)
                print("rectData x and y after ", rectData[bboxID-1])
//                RTdrawState = true
//                rectData[globalString.currentBoxID] = [startLoc.x + (drag.translation.width ), startLoc.y + (drag.translation.height ), rectData[globalString.currentBoxID][2], rectData[globalString.currentBoxID][3]]
            }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation // offset is the distance of drag by the user
//                print("offset : ",offset)
                checkCoordinates(coordinates: startLoc, coordinateList: &rectData, viewStateVal: viewState, withinBBOX: &withingBBox) // , STAT_update: statusUpdate
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
//                    if testButton == false{
                        print("checking within bbox",withingBBox)
                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                        print("Bbox drawn")
//                    }
                    // set the withingBBox boolean to false after drage is complete
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
//                    dragState.isPressDragging ?
//                pressDrag?
//                if statusUpdate.saveCurrentBbox == true{
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .path(in: CGRect(
                            x: (startLoc.x), // +  dragState.translation.width,
                            y: (startLoc.y), // + dragState.translation.height,
                            width: contWidth,
                            height: contHeight
                        )
                        )
                        .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.3))
//                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
//                        .offset(x: viewState.width + dragState.translation.width,
//                                y: viewState.height + dragState.translation.height)
//                : nil
//                }
                ForEach(self.rectData, id:\.self) {cords in
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .path(in: CGRect(
                            x: cords[0],
                            y: cords[1],
                            width: cords[2],
                            height: cords[3]
                        )
                        )
                        .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.3))
//                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                } // end of for each loop
            }) // end of image overlay and zstack inside it
            .gesture(simultaneously)
//            .environmentObject(statusUpdate)
    } // end of main body
}

func checkCoordinates(coordinates: CGPoint, coordinateList: inout [[CGFloat]], viewStateVal: CGSize, withinBBOX: inout Bool){
    // STAT_update: handleBoxControl
//    @StateObject var globalString = GlobalString() // call the global class to update the current bbox ID
//    print("function checkCoordinates called")
    bboxID = 0
    var withinBBoxArea = false
    withinBBOX = false
    
//    ForEach(coordinateList, id:\.self)
//    { bCord in
    for bCord in coordinateList{
        bboxID = bboxID + 1
        
        // This section checks if the tap on the screen is withing an already drawn bouding box
        if coordinates.x >= bCord[0]  && coordinates.x <= (bCord[0]+bCord[2])  && coordinates.y >= bCord[1] && coordinates.y <= (bCord[1]+bCord[3]) { // && bCord[1]+(bCord[2]+bCord[3]) >= coordinates.y
            print("actual coordinates:", coordinates.x, coordinates.y)
            print("withing bbox",bCord[0],bCord[1], bCord[0]+bCord[2], bCord[1]+bCord[3])
            print("working with bbox: ",bboxID)
            
            // if withing coordinates then return the bbox ID and set a boolean var to true.
            withinBBoxArea = true
            withinBBOX = true
//            STAT_update.saveCurrentBbox = false
//            statusUpdate.saveCurrentBbox = false
//            globalString.currentBoxID = bboxID
//            coordinateList[bboxID-1] = [coordinates.x + viewStateVal.width, coordinates.y + viewStateVal.height, coordinateList[bboxID-1][2], coordinateList[bboxID-1][3]]
        }
        
        // Check if the tap is at the top left corner 
        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            print("within C1 edge...")
        }
        
        // Check if the tap is at the top right corner
        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            print("within C2 edge...")
        }
        
        // Check if the tap is at the bottom left corner
        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
            print("within C3 edge...")
        }
        
        // Check if the tap is at the bottom right corner
        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
            print("within C4 edge...")
        }
        else{
//            withinBBoxArea = false
            continue
//            STAT_update.saveCurrentBbox = true
//            withinBBOX = false
        }

        
    }
    print(withinBBoxArea)
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
