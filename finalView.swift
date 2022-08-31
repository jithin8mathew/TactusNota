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
                //            case .withinBbox:
                //                return true
                //            case .isCorner:
                //                return true
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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct finalView_Previews: PreviewProvider {
    static var previews: some View {
        finalView()
    }
}
