//
//  testViewNew.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/9/22.
//

import SwiftUI

struct testViewNew: View {
    
    @State var startLoc = CGPoint.zero
    @State var contWidth = CGFloat.zero
    @State var contHeight = CGFloat.zero
    
    @State var rectData: [[CGFloat]] = []
    @State var rectCircleData: [Int:[CGFloat]] = [:]
    
    var body: some View {
            ZStack{
                Color(red: 0.26, green: 0.26, blue: 0.26)
                .ignoresSafeArea()
                
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
                        }
                        .onEnded({
                            (value) in
                            if (value.location.x - startLoc.x > 20){
                                rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                                rectCircleData[bboxID]=[startLoc.x, startLoc.y, contWidth, contHeight]
                                bboxID += 1
                            }
                            else{
                                print("start location: ", value.startLocation)
                                var count_annotation_cords = 0
                                    for cords in rectData{
                                        count_annotation_cords += 1
                                    
                                        if value.startLocation.x >= cords[0] && value.startLocation.x <= (cords[0] + cords[2])  && value.startLocation.y >= cords[1] && value.startLocation.y <= (cords[1] + cords[3]){
                                            print("value within selected bbox")
                                            print(count_annotation_cords)
                                        }
                                        else{
                                            continue
                                        }
                                    }
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
                                
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 15, height: 15)
                                    .position(x: cords[0], y: cords[1])
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 15, height: 15)
                                    .position(x: cords[0] + cords[2], y: cords[1])
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 15, height: 15)
                                    .position(x: cords[0], y: cords[1] + cords[3])
                                Circle()
                                    .fill(.yellow)
                                    .frame(width: 15, height: 15)
                                    .position(x: cords[0] + cords[2], y: cords[1] + cords[3])
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
