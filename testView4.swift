//
//  testView4.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/26/22.
//

import SwiftUI

struct testView4: View {
    
    var body: some View {
        ScrollView() {
            ForEach(0..<5, id: \.self) { i in
                ListElem()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct ListElem: View {
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    @GestureState var isTapping = false
    
    var body: some View {
        
        // Gets triggered immediately because a drag of 0 distance starts already when touching down.
        let tapGesture = DragGesture(minimumDistance: 0)
            .updating($isTapping) {_, isTapping, _ in
                isTapping = true
            }

        // minimumDistance here is mainly relevant to change to red before the drag
        let dragGesture = DragGesture(minimumDistance: 0)
            .onChanged {
                offset = $0.translation
                isDragging = true
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
//        let pressGesture = LongPressGesture(minimumDuration: 1.0)
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
        
        // The dragGesture will wait until the pressGesture has triggered after minimumDuration 1.0 seconds.
//        let combined = pressGesture.sequenced(before: dragGesture)
        
        // The new combined gesture is set to run together with the tapGesture.
        let simultaneously = tapGesture.simultaneously(with: dragGesture)
        
        return Circle()
            .overlay(isTapping ? Circle().stroke(Color.red, lineWidth: 5) : nil) //listening to the isTapping state
            .frame(width: 100, height: 100)
            .foregroundColor(isDragging ? Color.red : Color.black) // listening to the isDragging state.
            .offset(offset)
            .gesture(simultaneously)
        
    }
}


struct testView4_Previews: PreviewProvider {
    static var previews: some View {
        testView4()
    }
}
