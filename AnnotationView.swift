//
//  AnnotationView.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 9/12/22.
//

import SwiftUI

struct AnnotationView: View {
    
    @State var rectData: [[CGFloat]] = [] // global var to hold annotation coordinates
    @State var startLoc = CGPoint.zero // start location of the coordinate the user clicks
    @State var contWidth = CGFloat.zero // holds the width of the bounding box based on users drag
    @State var contHeight = CGFloat.zero // holds the height of the bbox based on users vertical drag
    
    // testing longPress Drag gesture
    @State var isDragging = false
    @State private var offset = CGSize.zero
    
    // tap gesture vars
    @GestureState var isTapped = false
    
    var body: some View {
        ZStack{
            Color(red: 0.26, green: 0.26, blue: 0.26)
                .ignoresSafeArea()
            
            let tapGesture = DragGesture(minimumDistance: 0)
                .updating($isTapped) {_, isTapped, _ in
                    isTapped = true
                }
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            let mainGesture = DragGesture(minimumDistance: 0)
                .onChanged {
                    (value) in //print(value.location)
                    startLoc = value.startLocation      // get the coordinates at which the user clicks to being annotating the object
                    contWidth = value.location.x - startLoc.x // the the width of the object (bounding box)
                    contHeight = value.location.y - startLoc.y // Height of the bounding box
                    offset = value.translation
                }
                .onEnded({
                    (value) in
                    if (value.location.x - startLoc.x > 20){
                        rectData.append(contentsOf:[[startLoc.x, startLoc.y, contWidth, contHeight]])
                    }
                }) // onEnded
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        } // end of zstack
    } // end of main body
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
