//
//  testViewNew.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/9/22.
//

import SwiftUI

struct testViewNew: View {
    
    enum DragState {
        case inactive
        case pressing
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
    
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    @State var rectData: [[CGFloat]] = []
    @State var rectCircleData: [Int:[CGFloat]] = [:] // holds the bbox ID and the four coordinates of the bbox corners
    
    // This section will move the bounding box to desired location after being drawn
    @GestureState var dragState = DragState.inactive
    
    // testing tapgesture
    @GestureState var isTapped = false
    
//    var tap: some Gesture {
//            TapGesture(count: 1)
//                .onEnded { _ in self.tapped = !self.tapped }
//        }
    
    var body: some View {
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                .ignoresSafeArea()
                
                
                let tapGesture = DragGesture(minimumDistance: 0)
                    .updating($isTapped) {_, isTapped, _ in
                        isTapped = true
                    }

                
//                Circle()
//                            .fill(self.tapped ? Color.blue : Color.red)
//                            .frame(width: 100, height: 100, alignment: .center)
//                            .position(x: 50, y: 50)
//                            .gesture(tap)
                
                Image("test1")
                    .resizable()
                    .cornerRadius(20)
                    .font(.title)
                    .padding(.all, 5)
                    .shadow(color: Color(red: 0.16, green: 0.16, blue: 0.16), radius: 5, x: 15, y: 15)
                    .gesture(
//                        if LongPressGesture(minimumDuration: 0.2)
//                        {
//                            print("long press gesture tapped")
//                        }
//                        if DragGesture(minimumDistance: 0)
//                            .onChanged {
//
//                        }
                        DragGesture(minimumDistance: 0)
                        .onChanged {
                            (value) in //print(value.location)
                            startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                            contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                            contHeight = value.location.y - startLoc.y // Height of the bounding box
                            
                            for (boundingBoxID, bboxCoordinates) in rectCircleData{
                                if value.startLocation.x >=  (bboxCoordinates[0]-15) && value.startLocation.x <= ( bboxCoordinates[0] +  15)  && value.startLocation.y >=  (bboxCoordinates[1] - 15) && value.startLocation.y <= ( bboxCoordinates[1] +  15){
                                    
                                        rectData[boundingBoxID] = [bboxCoordinates[0] - (-1 * (value.location.x - startLoc.x)), bboxCoordinates[1] - (-1 * (value.location.y - startLoc.y)), bboxCoordinates[2] + (-1 * (value.location.x - startLoc.x)), bboxCoordinates[3] + (-1 * (value.location.y - startLoc.y))]
                                        startLoc.x = bboxCoordinates[0] - (-1 * (value.location.x - startLoc.x))
                                        startLoc.y = bboxCoordinates[1] - (-1 * (value.location.y - startLoc.y))
                                        contWidth = bboxCoordinates[2] + (-1 * (value.location.x - startLoc.x))
                                        contHeight = bboxCoordinates[3] + (-1 * (value.location.y - startLoc.y))
                                }
                            }
                        }
                        .onEnded({
                            (value) in
                            if (value.location.x - startLoc.x > 20){
                                rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                                rectCircleData[bboxID]=[startLoc.x, startLoc.y, contWidth, contHeight]
                                bboxID += 1
                                print(rectCircleData)
                            }
                            else{
//                                print("start location: ", value.startLocation)
                                var count_annotation_cords = 0
                                for (boundingBoxID, bboxCoordinates) in rectCircleData{
//                                    print("(\(key),\(value))")
                                    count_annotation_cords += 1
                                    
                                    // this section is not working yet
//                                    if value.startLocation.x >= bboxCoordinates[0]+15 || value.startLocation.x <= bboxCoordinates[0]-15 {
//                                    if value.startLocation.x >=  (bboxCoordinates[0]-15) && value.startLocation.x <= ( bboxCoordinates[0] +  15)  && value.startLocation.y >=  (bboxCoordinates[1] - 15) && value.startLocation.y <= ( bboxCoordinates[1] +  15){
//                                        rectCircleData[boundingBoxID] = nil
//                                        rectData[boundingBoxID] = [bboxCoordinates[0] - abs(value.location.x - startLoc.x), bboxCoordinates[1] - abs(value.location.y - startLoc.y), bboxCoordinates[2] + abs(value.location.x - startLoc.x), bboxCoordinates[3] + abs(value.location.y - startLoc.y)]
//
////                                        startLoc.x = bboxCoordinates[0] - abs(value.location.x - startLoc.x)
////                                        startLoc.y = bboxCoordinates[1] - abs(value.location.y - startLoc.y)
////                                        contWidth = bboxCoordinates[2] + abs(value.location.x - startLoc.x)
////                                        contHeight = bboxCoordinates[3] + abs(value.location.y - startLoc.y)
////                                        print(bboxCoordinates[0] + value.startLocation.x, bboxCoordinates[1] + value.startLocation.y, bboxCoordinates[2], bboxCoordinates[3])
//                                        rectCircleData[boundingBoxID] = [value.startLocation.x, value.startLocation.y, bboxCoordinates[2], bboxCoordinates[3]]
//                                        print(rectCircleData[boundingBoxID])
//                                        print("Coordinate C1 clicked", startLoc.x, bboxCoordinates[0])
//                                    }
                                    if value.startLocation.x >=  ((bboxCoordinates[0]-15) + bboxCoordinates[2]) && value.startLocation.x <= ((bboxCoordinates[0] + 15) + bboxCoordinates[2])  && value.startLocation.y >=  (bboxCoordinates[1] - 15) && value.startLocation.y <=  (bboxCoordinates[1] +  15){
                                        print("Coordinate C2 clicked", startLoc.x, bboxCoordinates[0] + bboxCoordinates[2])
                                    }
                                    else if value.startLocation.x >=  (bboxCoordinates[0]-15) && value.startLocation.x <= (bboxCoordinates[0] + 15)   && value.startLocation.y >=  ((bboxCoordinates[1] - 15) + bboxCoordinates[3]) && value.startLocation.y <=  ((bboxCoordinates[1] +  15) + bboxCoordinates[3]){
                                        print("Coordinate C3 clicked", startLoc.x, bboxCoordinates[0] + bboxCoordinates[2])
                                    }
                                    else if value.startLocation.x >=  ((bboxCoordinates[0]-15) + bboxCoordinates[2]) && value.startLocation.x <= ((bboxCoordinates[0] + 15) + bboxCoordinates[2])  && value.startLocation.y >=  ((bboxCoordinates[1] - 15) + bboxCoordinates[3]) && value.startLocation.y <=  ((bboxCoordinates[1] +  15) + bboxCoordinates[3]){
                                        print("Coordinate C4 clicked", startLoc.x, bboxCoordinates[0] + bboxCoordinates[2])
                                    }
                                    else{
                                        continue
                                    }
                                    if value.startLocation.x >=  bboxCoordinates[0] && value.startLocation.x <= ( bboxCoordinates[0] +  bboxCoordinates[2])  && value.startLocation.y >=  bboxCoordinates[1] && value.startLocation.y <= ( bboxCoordinates[1] +  bboxCoordinates[3]){
                                        print("value within selected bbox")
                                        print(count_annotation_cords, boundingBoxID) // this is where we check if the clicked coordinates are within an existing bounding box
                                    }
                                    else{
                                        continue
                                    }
                                }
//                                    for cords in rectData{
//                                        count_annotation_cords += 1
//
//                                        if value.startLocation.x >= cords[0] && value.startLocation.x <= (cords[0] + cords[2])  && value.startLocation.y >= cords[1] && value.startLocation.y <= (cords[1] + cords[3]){
//                                            print("value within selected bbox")
//                                            print(count_annotation_cords)
//                                        }
//                                        else{
//                                            continue
//                                        }
//                                    }
                            }
                        })
                    )
                    .overlay( ZStack{
                        RoundedRectangle(cornerRadius: 5, style: .circular)
                            .path(in: CGRect(
                                x: (startLoc.x),
                                y: (startLoc.y), //(3.12 * 2),
                                width: contWidth, //(4.68 * 2),
                                height: contHeight
                                )
                            )
                            .fill(Color(red: 0.0, green: 0, blue: 1.0, opacity: 0.2))
                        
                        RoundedRectangle(cornerRadius: 5, style: .circular)
                            .path(in: CGRect(
                                x: (startLoc.x),
                                y: (startLoc.y), //(3.12 * 2),
                                width: contWidth, //(4.68 * 2),
                                height: contHeight
                                )
                            )
                            .stroke(Color(red: 1.0, green: 0.78, blue: 0.16), lineWidth: 3.0)
                        Circle()
                            .fill(.yellow)
                            .frame(width: 15, height: 15)
                            .position(x: startLoc.x, y: startLoc.y)
                        Circle()
                            .fill(.yellow)
                            .frame(width: 15, height: 15)
                            .position(x: startLoc.x + contWidth, y: startLoc.y)
                        Circle()
                            .fill(.yellow)
                            .frame(width: 15, height: 15)
                            .position(x: startLoc.x, y: startLoc.y + contHeight)
                        Circle()
                            .fill(.yellow)
                            .frame(width: 15, height: 15)
                            .position(x: startLoc.x + contWidth, y: startLoc.y + contHeight)
                        
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
                                
//                                Circle()
//                                    .fill(.yellow)
//                                    .frame(width: 15, height: 15)
//                                    .position(x: cords[0], y: cords[1])
//                                Circle()
//                                    .fill(.yellow)
//                                    .frame(width: 15, height: 15)
//                                    .position(x: cords[0] + cords[2], y: cords[1])
//                                Circle()
//                                    .fill(.yellow)
//                                    .frame(width: 15, height: 15)
//                                    .position(x: cords[0], y: cords[1] + cords[3])
//                                Circle()
//                                    .fill(.yellow)
//                                    .frame(width: 15, height: 15)
//                                    .position(x: cords[0] + cords[2], y: cords[1] + cords[3])
                            } // end of ForEach
                    })
            }
        }
}

struct testViewNew_Previews: PreviewProvider {
    static var previews: some View {
        testViewNew()
    }
}
