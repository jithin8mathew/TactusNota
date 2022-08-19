//
//  testview2.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 8/18/22.
//

import SwiftUI

struct testview2: View {
    @State private var location: CGPoint = CGPoint(x: 50, y: 50)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil // 1
    
    @GestureState private var pressing = false
    
    var longpressGesture: some Gesture{
        LongPressGesture(minimumDuration: 0.2, maximumDistance: 20)
            .updating($pressing) { currentState, gestureState, transaction in
                gestureState = currentState
                        }
            .onEnded { value in
                print("long pressed")
                }
    }
        
        var simpleDrag: some Gesture {
            DragGesture()
                .onChanged { value in
                    var newLocation = startLocation ?? location // 3
                    newLocation.x += value.translation.width
                    newLocation.y += value.translation.height
                    self.location = newLocation
                }.updating($startLocation) { (value, startLocation, transaction) in
                    startLocation = startLocation ?? location // 2
                }
        }
        
        var fingerDrag: some Gesture {
            DragGesture()
                .updating($fingerLocation) { (value, fingerLocation, transaction) in
                    fingerLocation = value.location
                }
        }
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.pink)
                    .frame(width: 100, height: 100)
                    .position(location)
                    .gesture(
                        simpleDrag.simultaneously(with: fingerDrag)
                    )
                if let fingerLocation = fingerLocation {
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width: 44, height: 44)
                        .position(fingerLocation)
                }
                Circle()
                    .stroke(Color.green, lineWidth: 2)
                    .frame(width: 44, height: 44)
                    .scaleEffect(pressing ? 2 : 1)
                    .position(x:250 , y: 250)
                    .gesture(
                        longpressGesture
                    )
                
            }
        }
}

struct testview2_Previews: PreviewProvider {
    static var previews: some View {
        testview2()
    }
}
