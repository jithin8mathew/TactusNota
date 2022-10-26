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
    
    //    @GestureState var dragState = DragState.inactive
    @State var boxID = 0
    
    // becomes ture if the user raps or drags within the bounding box
    @State var withingBBox = false
    // Trun this update on or off to prevent bounding box from being drawn when the user is dragging an existing bbox
    @State var RTdrawState = true
    
    @State var testButton = false
    
    @State var didLongPress = false
    @GestureState var isLongPressing = false
    @State var completedLongPress = false
    @State var previous_offsetX = 0.0
    @State var previous_offsetY = 0.0
    @State var boxIDVAL = 0
    //    @State var selectedCorner: [bboxCorner] = []
    @State var C1 = false
    @State var C2 = false
    @State var C3 = false
    @State var C4 = false
    
    @State var dragLock = false // This section prevents from dragging the bounding boxes around
    @State var resizeLock = false // This section prevents the bounding box from being resized
    @State var resizeDragState = false
    
    @State var prev_f_width = 0.0
    @State var prev_f_height = 0.0
    
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
                resizeLock = false
            }
        
        //            .sequenced(before: DragGesture()) // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-gesture-chains-using-sequencedbefore
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mainGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                (value) in //print(value.location)
                var f_width=0.0
                var f_height=0.0
                startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                contHeight = value.location.y - startLoc.y // Height of the bounding box
                offset = value.translation // offset is the distance of drag by the user
//                globalCord.startTap_coordinate = startLoc // assign the startloc to global var
                if resizeLock == false && self.completedLongPress == false{
                    let coordinateManager =  checkCoordinates(coordinates: startLoc, coordinateList: &rectData, viewStateVal: viewState, withinBBOX: &withingBBox) // , STAT_update: statusUpdate
                    boxIDVAL = coordinateManager.1
                    resizeBoundingBox(coordinates: startLoc, coordinateList: &rectData, offset_value: offset, C1_: &C1, C2_: &C2, C3_: &C3, C4_: &C4)
//                    print("C1 status: ", C1)
                    if C1 == true && boxIDVAL != 0{
                        dragLock = true
                        //                        C1 = true
                        
                        f_width = contWidth - f_width
                        f_height =  contHeight - f_height
                        prev_f_width = f_width - prev_f_width
                        prev_f_height = f_height - prev_f_height
                        incrementTracker(startLocationValue: startLoc, currentDragPosition: value.location)
//                        print(abs(startLoc.x)-abs(value.location.x),"absolute testing")// mother of all printing
//                        var current_valll = abs(startLoc.x)-abs(value.location.x)
//                        print(abs(startLoc.x)-abs(current_valll),"abs abs testing")
//                        var prev_valll = abs(startLoc.x)-abs(value.location.x)
//                        print(prev_f_width, prev_f_height, "PREVIOUS")

//                        print("width:",f_width, "height:",f_height)
//                        print([rectData[boxIDVAL-1][0] - abs(f_width), rectData[boxIDVAL-1][1] - abs(f_height), rectData[boxIDVAL-1][2] + abs(f_width), rectData[boxIDVAL-1][3] + abs(f_height)])
                        //                        print([rectData[boxIDVAL-1][0] - (-1 * (previous_offsetX)), rectData[boxIDVAL-1][1] - (-1 * (previous_offsetY)), rectData[boxIDVAL-1][2] + (-1 * (previous_offsetX)), rectData[boxIDVAL-1][3] + (-1 * (previous_offsetY))])
                        //                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - (-1 * (contWidth)), rectData[boxIDVAL-1][1] - (-1 * (contHeight)), rectData[boxIDVAL-1][2] + (-1 * (contWidth)), rectData[boxIDVAL-1][3] + (-1 * (contHeight))]
                        rectData[boxIDVAL-1] = [rectData[boxIDVAL-1][0] - abs(prev_f_width), rectData[boxIDVAL-1][1] - abs(prev_f_height), rectData[boxIDVAL-1][2] + abs(prev_f_width), rectData[boxIDVAL-1][3] + abs(prev_f_height)]
                        
                    }
                    
                }
                
                //                print("BoxIDVAL", boxIDVAL)
                if self.completedLongPress == true{
                    dragLock = false
                }
                if self.completedLongPress == true && boxIDVAL != 0 && dragLock == false{ // checking if boxIDVAL value is 0 is a clever way to handle long press guestures outside the bounding boxes
                    resizeLock = true
                    previous_offsetX = startLoc.x - (rectData[boxIDVAL-1][2]/2)
                    previous_offsetY = startLoc.y - (rectData[boxIDVAL-1][3]/2)
                    rectData[boxIDVAL-1] = [previous_offsetX + offset.width , previous_offsetY + offset.height, rectData[boxIDVAL-1][2], rectData[boxIDVAL-1][3]]
                    //                    print("OFFSET CORRECTION:", rectData[boxIDVAL-1][0]+offset.width,rectData[boxIDVAL-1][1]+offset.height)
                    //                    print("OFFSET CORRECTION TWO:", previous_offsetX,previous_offsetY)
                }
            }
            .onEnded({
                (value) in
                if (value.location.x - startLoc.x > 20){
                    if self.completedLongPress == false{
                        //                        print("checking within bbox",withingBBox)
                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                        //                        print("Bbox drawn")
                    }
                    //                    else if {
                    //
                    //                    }
                    // set the withingBBox boolean to false after drage is complete
                }
                //                delayUpdate() // this dones not work because of "'async' call in a function that does not support concurrency"
                self.completedLongPress = false
                dragLock = false
                resizeLock = false
                C1 = false
                
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
                if self.completedLongPress == false{
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .path(in: CGRect(
                            x: (startLoc.x), // +  dragState.translation.width,
                            y: (startLoc.y), // + dragState.translation.height,
                            width: contWidth,
                            height: contHeight
                        )
                        )
                    //                    .fill(Color(red: 1.0, green: 0.78, blue: 0.16, opacity: 0.3))
                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                    //                        .offset(x: viewState.width + dragState.translation.width,
                    //                                y: viewState.height + dragState.translation.height)
                    //                                : nil
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
                    //                        .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
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
    var withinBBoxArea = false
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
            withinBBoxArea = true
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

func resizeBoundingBox(coordinates: CGPoint, coordinateList: inout [[CGFloat]], offset_value: CGSize, C1_: inout Bool, C2_: inout Bool, C3_: inout Bool, C4_: inout Bool){
    // , selectedCorner_:bboxCorner
    bboxID = 0
    for bCord in coordinateList{
        bboxID = bboxID + 1
        
        //        var C1_ = false
        
        if bCord[0] >=  (coordinates.x - 15) && bCord[0] <= ( coordinates.x + 15)  && bCord[1] >=  (coordinates.y - 15) && bCord[1] <= ( coordinates.y + 15){
            C1_ = true
            C2_ = false
            C3_ = false
            C4_ = false
            //            coordinateList[bboxID-1] = [coordinateList[bboxID-1][0]+offset_value.width, coordinateList[bboxID-1][1]+offset_value.height, coordinateList[bboxID-1][2]+offset_value.width, coordinateList[bboxID-1][3]+offset_value.height]
            //
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
        //        else{
        //            C1_ = false
        //            C2_ = false
        //            C3_ = false
        //            C4_ = false
        //        }
    }
}

func incrementTracker(startLocationValue: CGPoint, currentDragPosition: CGPoint){
    
//    @StateObject var globalCord = GlobalCoordination()
    var SLV = startLocationValue
//    globalCord.startTap_coordinate.x = abs(currentDragPosition.x)-abs(SLV.x)  // SLV : Start Location Value
//    globalCord.startTap_coordinate.y = abs(currentDragPosition.y)-abs(SLV.y)  // SLV : Start Location Value
    print(SLV, currentDragPosition)
//    print("XXXXX increment :", abs(globalCord.startTap_coordinate.x) - abs(currentDragPosition.x)-abs(SLV.x))
//    print("YYYYY increment :", abs(globalCord.startTap_coordinate.y) - abs(currentDragPosition.y)-abs(SLV.y))
    print("X increment :", abs(currentDragPosition.x)-abs(SLV.x))
    print("Y increment :", abs(currentDragPosition.y)-abs(SLV.y))
    SLV.x = currentDragPosition.x
    SLV.y = currentDragPosition.y
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
