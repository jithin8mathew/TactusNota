//
//  finalView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/31/22.
//

import SwiftUI

struct finalView: View {
    
    enum AnnotationState {
        case dragging(translation: CGSize) // draging for bbox annotation, either it is in open space or within already drawn bbox
        case longPressing // long pressing is only for dragging an already drawn bbox
        case inactive // all other time when screen is inactive
        
        var translation: CGSize {
            switch self {
            case .inactive, .longPressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .longPressing, .dragging:
                return true
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive, .longPressing:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    enum AnnotatoinLocation {
        case withinBbox
        case isCorner
        
        var withinBBox: Bool{
            switch self {
            case .withinBbox:
                return true
            case .isCorner:
                return true

            }
        }
    }
    
    @GestureState var dragState = AnnotationState.inactive // represents the state of the object being drageed 
    @State var viewState = CGSize.zero // updates the location of the object being dragged
    
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    var body: some View {
        let minimumLongPressDuration = 0.2
        let longPressDrag = LongPressGesture(minimumDuration: minimumLongPressDuration)
            .sequenced(before: DragGesture())
            .updating($dragState) { value, state, transaction in
                switch value {
                // Long press begins.
                case .first(true):
                    state = .longPressing
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
        
        return Rectangle()
                    .fill(Color.blue)
                    .overlay(dragState.isDragging ? Rectangle().stroke(Color.white, lineWidth: 2) : nil)
                    .frame(width: 100, height: 100, alignment: .center)
                    .offset(
                        x: viewState.width + dragState.translation.width,
                        y: viewState.height + dragState.translation.height
                    )
                    .animation(nil)
                    .shadow(radius: dragState.isActive ? 8 : 0)
                    .animation(.linear(duration: minimumLongPressDuration))
                    .gesture(longPressDrag)
//        return  RoundedRectangle(cornerRadius: 5, style: .circular)
//            .path(in: CGRect(
//                x: 100,
//                y: 100,
//                width: self.viewState.width,
//                height: self.viewState.height
//            )
//            )
//            .shadow(radius: dragState.isActive ? 8 : 0)
//            .animation(.linear(duration: minimumLongPressDuration))
//            .gesture(longPressDrag)
    }
}

struct finalView_Previews: PreviewProvider {
    static var previews: some View {
        finalView()
    }
}
