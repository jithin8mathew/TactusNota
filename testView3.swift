//
//  testView3.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/20/22.
//

import SwiftUI

struct testView3: View {

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
    
    @GestureState var dragState = DragState.inactive
    @State var viewState = CGSize.zero
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    var body: some View {
        
        let mainGesture = DragGesture(minimumDistance: 0)
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
                    print("Bbox drawn")
                    // set the withingBBox boolean to false after drage is complete
                }
            }) // onEnded
        
            let minimumLongPressDuration = 0.2
            let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
                .sequenced(before: DragGesture())
                .updating($dragState) { value, state, transaction in
                    switch value {
                    // Long press begins.
                    case .first(true):
                        state = .pressing
                    // Long press confirmed, dragging may begin.
                    case .second(true, let drag):
                        state = .dragging(translation: drag?.translation ?? .zero)
                    // Dragging ended or the long press cancelled.
                    default:
                        state = .inactive
                    }
                }
                .onEnded { value in
                    guard case .second(true, let drag?) = value else { return }
                    self.viewState.width += drag.translation.width
                    self.viewState.height += drag.translation.height
                }
        
        return RoundedRectangle(cornerRadius: 5, style: .circular)
            .path(in: CGRect(
                x: viewState.width + dragState.translation.width,
                y: viewState.height + dragState.translation.height,
                width: 100,
                height: 100
            )
            )
            .fill(Color.blue)
            .animation(nil)
            .shadow(radius: dragState.isActive ? 8 : 0)
            .animation(.linear(duration: minimumLongPressDuration))
            .gesture(longPressDrag)
            
        
//        return Rectangle()
//                    .fill(Color.blue)
//                    .overlay(dragState.isDragging ? Rectangle().stroke(Color.white, lineWidth: 2) : nil)
//                    .frame(width: 100, height: 100, alignment: .center)
//                    .offset(
//                        x: viewState.width + dragState.translation.width,
//                        y: viewState.height + dragState.translation.height
//                    )
//                    .animation(nil)
//                    .shadow(radius: dragState.isActive ? 8 : 0)
//                    .animation(.linear(duration: minimumLongPressDuration))
//                    .gesture(longPressDrag)
            }
}



struct testView3_Previews: PreviewProvider {
    static var previews: some View {
        testView3()
    }
}
