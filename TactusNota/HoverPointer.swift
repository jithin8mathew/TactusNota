//
//  HoverPointer.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 5/1/23.
//

import SwiftUI

struct HoverPointer: UIViewRepresentable {
    typealias UIViewType = HoverDrawView

    func makeUIView(context: Context) -> HoverDrawView {
        return HoverDrawView()
    }

    func updateUIView(_ uiView: HoverDrawView, context: Context) {
        // No need to update anything here
    }
}
