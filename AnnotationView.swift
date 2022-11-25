//
//  AnnotationView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 9/12/22.
//

import SwiftUI

//class handleBoxControl: ObservableObject{
//    @Published var saveCurrentBbox = true
//}

// create a @Published to receive current bbox that user is working with for moving and resizing etc
//class GlobalCoordination: ObservableObject{
//    @Published var startTap_coordinate = CGPoint()
//}

struct AnnotationView: View {
    
//    @StateObject var globalCord = GlobalCoordination()
    //    @StateObject var globalString = GlobalString()
    //    @EnvironmentObject var statusUpdate: handleBoxControl
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    // testing longPress Drag gesture
//    @State var isDragging = false
    @State private var offset = CGSize.zero
    @State var viewState = CGSize.zero
    
    //     tap gesture vars
    //    @GestureState var isTapped = false
    
    // long press Geusture vars
//    @GestureState var press = false
//    @State var show = false
    //    @State var pressDrag = false
    //    @GestureState var location = CGPoint(x:0, y:0)
    
    // drag gesture
//    @State var isDraggable = false
//    @State var translation = CGSize.zero
    
    //    @GestureState var dragState = DragState.inactive
//    @State var boxID = 0
    
    // becomes ture if the user raps or drags within the bounding box
    @State var withingBBox = false
    // Trun this update on or off to prevent bounding box from being drawn when the user is dragging an existing bbox
//    @State var RTdrawState = true
    
//    @State var testButton = false
    
    @State var didLongPress = false
    @GestureState var isLongPressing = false
    @State var completedLongPress = false
    @State var previous_offsetX = 0.0
    @State var previous_offsetY = 0.0
    @State var boxIDVAL = 0
    @State var test_boxIDVAL = 0
    @State var previous_boxIDVAL = 0
    //    @State var selectedCorner: [bboxCorner] = []
    
    // used to keep track of the bounding box corner that is being dealt with
    @State var C1 = false   // top left
    @State var C2 = false   // top right
    @State var C3 = false   // bottom left
    @State var C4 = false   // bottom right
    
    @State var dragLock = false // This section prevents from dragging the bounding boxes around
    @State var resizeLock = false // This section prevents the bounding box from being resized
//    @State var resizeDragState = false
    
    @State var prev_f_width = 0.0 // temp var for prev width - current width
    @State var prev_f_height = 0.0 // temp var for prev hieght - current height
    
//    @State var prev_start_loc = CGPoint.zero
    @State var cordData: [[CGFloat]] = [] // cordData is a temporary list that gets populated with coordinates when bbox edge is dragged. The purpose of this list is to substract the previous cordinate values from the current. The differecne is used to resize the bounding box.
    
    // switch case state value holder
    //    @State var viewState = CGSize.zero
    
    var body: some View {
        //        ZStack{
        //            Color(red: 0.26, green: 0.26, blue: 0.26)
        //                .ignoresSafeArea()
        
        let longPressGesture = LongPressGesture(minimumDuration: 0.5)
        
            .updating($isLongPressing) { currentState, gestureState,
                transaction in
                gestureState = currentState
                //                transaction.animation = Animation.easeIn(duration: 2.0)
            }
            .onEnded { finished in
                self.completedLongPress = finished
                print("LONG PRESS STATUS:",self.completedLongPress)
                let coordinateManager =  checkCoordinates(coordinates: startLoc, coordinateList: &rectData, viewStateVal: viewState, withinBBOX: &withingBBox) // , STAT_update: statusUpdate
                boxIDVAL = coordinateManager.1
                resizeLock = true
            }
        
        //            .sequenced(before: DragGesture()) // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-gesture-chains-using-sequencedbefore
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
//                var f_width=0.0
//                var f_height=0.0
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation // offset is the distance of drag by the user
//                globalCord.startTap_coordinate = startLoc // assign the startloc to global var
                print(resizeLock, self.completedLongPress, dragLock, C1)
                if resizeLock == false && self.completedLongPress == false{
//                    let coordinateManager =  checkCoordinates(coordinates: startLoc, coordinateList: &rectData, viewStateVal: viewState, withinBBOX: &withingBBox) // , STAT_update: statusUpdate
//                    boxIDVAL = coordinateManager.1
                    
                    resizeBoundingBox(coordinates: startLoc, coordinateList: &rectData, offset_value: offset, C1_: &C1, C2_: &C2, C3_: &C3, C4_: &C4, test_boxIDVAL_: &test_boxIDVAL)
                    
                    boxIDVAL = test_boxIDVAL
                    print(boxIDVAL,"initially")
                    if C1 == true { // && boxIDVAL != 0 : this condition is preventing the bbox from being resized below the original size
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        print((value.location.x-startLoc.x),(value.location.y-startLoc.y))
//                        var a = value.location.x-startLoc.x
//                        var b = value.location.y-startLoc.y
                        print(boxIDVAL,"finally")
//                        print(dragLock)
                        
                        // add previous C1 coordinate to a list to substract from later
                        if cordData.count > 2{
//                            print("CorData : ",cordData[cordData.count-2][0] - cordData[cordData.count-1][0])
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
//                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - abs(prev_f_width), rectData[boxIDVAL-1][1] - abs(prev_f_height), rectData[boxIDVAL-1][2] + abs(prev_f_width), rectData[boxIDVAL-1][3] + abs(prev_f_height)] // reduce x and y value while increasing the width and height with the same value
//                        if a && b < 0 {
                            rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - (prev_f_width), rectData[boxIDVAL-1][1] - (prev_f_height), rectData[boxIDVAL-1][2] + (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height)] // reduce x and y value while increasing the width and height with the same value
//                        }
//                        else{
//                            rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] + (prev_f_width), rectData[boxIDVAL-1][1] + (prev_f_height), rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] - (prev_f_height)] // reduce x and y value while increasing the width and height with the same value

//                        }
                        
                        
                    }
                    if C2 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1] - prev_f_height, rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] + (prev_f_height)]
                    }
                    if C3 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - prev_f_width , rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] + abs(prev_f_width), rectData[boxIDVAL-1][3] - prev_f_height ]
                    }
                    if C4 == true && boxIDVAL != 0{
                        dragLock = true
                        cordData.append([(value.location.x-startLoc.x),(value.location.y-startLoc.y)])
                        
                        if cordData.count > 2{
                            prev_f_width = cordData[cordData.count-2][0] - cordData[cordData.count-1][0]
                            prev_f_height = cordData[cordData.count-2][1] - cordData[cordData.count-1][1]
                        }
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0], rectData[boxIDVAL-1][1], rectData[boxIDVAL-1][2] - (prev_f_width), rectData[boxIDVAL-1][3] - (prev_f_height)]
                    }
                    
                }
//                if resizeLock == true && self.completedLongPress == true{
//                        print(resizeLock, completedLongPress)
//                }
                
                //                print("BoxIDVAL", boxIDVAL)
                if self.completedLongPress == true{
                    dragLock = false
                }
                if self.completedLongPress == true && boxIDVAL != 0 && dragLock == false{ // checking if boxIDVAL value is 0 is a clever way to handle long press guestures outside the bounding boxes
                    resizeLock = true
                    previous_offsetX = startLoc.x - (rectData[boxIDVAL-1][2]/2)
                    previous_offsetY = startLoc.y - (rectData[boxIDVAL-1][3]/2)
                    rectData[boxIDVAL-1] = [previous_offsetX + offset.width , previous_offsetY + offset.height, rectData[boxIDVAL-1][2], rectData[boxIDVAL-1][3]]
                }
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
                    if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                        //                        print("checking within bbox",withingBBox)
                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                        //                        print("Bbox drawn")
                    }
                }
                self.completedLongPress = false
                dragLock = false
                resizeLock = false
                C1 = false
                C2 = false
                C3 = false
                C4 = false
                cordData = []
                
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
            .overlay(ZStack{
                //                    dragState.isPressing ?
                //                self.completedLongPress ?
                if self.completedLongPress == false && C1 == false && C2 == false && C3 == false && C4 == false{
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .path(in: CGRect(
                            x: (startLoc.x), // +  dragState.translation.width,
                            y: (startLoc.y), // + dragState.translation.height,
                            width: contWidth,
                            height: contHeight
                        )
                        )
                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                }
                ForEach(self.rectData, id:\.self) {cords in
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .path(in: CGRect(
                            x: cords[0],
                            y: cords[1],
                            width: cords[2],
                            height: cords[3]
                        )
                        )
                        .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.6))
                    //  .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                } // end of for each loop
            }) // end of image overlay and zstack inside it
            .gesture(simultaneously)
        //            .environmentObject(statusUpdate)
    } // end of main body
    
    //    private func delayUpdate() async {
    //        try? await Task.sleep(nanoseconds: 7_500_000_000)
    //        self.completedLongPress = false
    //        }
}

func checkCoordinates(coordinates: CGPoint, coordinateList: inout [[CGFloat]], viewStateVal: CGSize, withinBBOX: inout Bool) -> (Bool, Int){
    
    bboxID = 0
    var temp_boxID = 0
//    var withinBBoxArea = false
    withinBBOX = false
    
    //    ForEach(coordinateList, id:\.self)
    //    { bCord in
    for bCord in coordinateList{
        bboxID = bboxID + 1
        
        // This section checks if the tap on the screen is withing an already drawn bouding box
        if coordinates.x >= bCord[0]  && coordinates.x <= (bCord[0]+bCord[2])  && coordinates.y >= bCord[1] && coordinates.y <= (bCord[1]+bCord[3]) { // && bCord[1]+(bCord[2]+bCord[3]) >= coordinates.y
            //            print("actual coordinates:", coordinates.x, coordinates.y)
            //            print("withing bbox",bCord[0],bCord[1], bCord[0]+bCord[2], bCord[1]+bCord[3])
            //            print("working with bbox: ",bboxID)
            
            // if withing coordinates then return the bbox ID and set a boolean var to true.
//            withinBBoxArea = true
            withinBBOX = true
            temp_boxID = bboxID
            return (withinBBOX, bboxID)
        }
        
        // Check if the tap is at the top left corner
        //        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
        //            print("within C1 edge...")
        //            //            coordinateList[bboxID][0] += coordinates.x
        //            //            coordinateList[bboxID][1] += coordinates.y
        //        }
        //
        //        // Check if the tap is at the top right corner
        //        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
        //            print("within C2 edge...")
        //        }
        //
        //        // Check if the tap is at the bottom left corner
        //        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
        //            print("within C3 edge...")
        //        }
        //
        //        // Check if the tap is at the bottom right corner
        //        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
        //            print("within C4 edge...")
        //        }
        else{
            continue
            //            return (withinBBOX, 0)
        }
    }
    //    print(withinBBoxArea)
    return (withinBBOX, temp_boxID)
}

func resizeBoundingBox(coordinates: CGPoint, coordinateList: inout [[CGFloat]], offset_value: CGSize, C1_: inout Bool, C2_: inout Bool, C3_: inout Bool, C4_: inout Bool, test_boxIDVAL_: inout Int){
    // , selectedCorner_:bboxCorner
    bboxID = 0
    for bCord in coordinateList{
        bboxID = bboxID + 1
//        test_boxIDVAL_ = bboxID
        
        //        var C1_ = false
        
        if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            C1_ = true
            C2_ = false
            C3_ = false
            C4_ = false
            test_boxIDVAL_ = bboxID
            //            coordinateList[bboxID-1] = [coordinateList[bboxID-1][0]+offset_value.width, coordinateList[bboxID-1][1]+offset_value.height, coordinateList[bboxID-1][2]+offset_value.width, coordinateList[bboxID-1][3]+offset_value.height]
            //
            print("within C1 edge...")
        }
        
        // Check if the tap is at the top right corner
        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            
            C1_ = false
            C2_ = true
            C3_ = false
            C4_ = false
            test_boxIDVAL_ = bboxID
            
            print("within C2 edge...")
        }
        
        // Check if the tap is at the bottom left corner
        else if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
            C1_ = false
            C2_ = false
            C3_ = true
            C4_ = false
            test_boxIDVAL_ = bboxID
            print("within C3 edge...")
        }
        
        // Check if the tap is at the bottom right corner
        else if bCord[0] + bCord[2] >=  (coordinates.x - 15) && bCord[0] + bCord[2] <= ( coordinates.x + 15)  && bCord[1] + bCord[3] >=  (coordinates.y - 15) && bCord[1] + bCord[3] <= ( coordinates.y + 15){
            C1_ = false
            C2_ = false
            C3_ = false
            C4_ = true
            test_boxIDVAL_ = bboxID
            print("within C4 edge...")
        }
        //        else{
        //            C1_ = false
        //            C2_ = false
        //            C3_ = false
        //            C4_ = false
        //        }
    }
}

//func incrementTracker(startLocationValue: CGPoint, currentDragPosition: CGPoint){
//
////    @StateObject var globalCord = GlobalCoordination()
//    var SLV = CGPoint.zero
//    var prev_SLV = CGPoint.zero
//    if SLV == CGPoint.zero{
//        var SLV = startLocationValue
//    }
//    else{
//        SLV = prev_SLV
//    }
////    prev_SLV = SLV
//
//    print(SLV, currentDragPosition)
//    print("X increment :", abs(currentDragPosition.x)-abs(SLV.x))
//    print("Y increment :", abs(currentDragPosition.y)-abs(SLV.y))
//    prev_SLV.x = currentDragPosition.x
//    prev_SLV.y = currentDragPosition.y
//}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
