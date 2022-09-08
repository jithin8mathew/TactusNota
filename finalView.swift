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
    
    @GestureState var dragState = AnnotationState.inactive
    
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
//                self.viewState.width += drag.translation.width
//                self.viewState.height += drag.translation.height
            }
    }
}

struct finalView_Previews: PreviewProvider {
    static var previews: some View {
        finalView()
    }
}
