//
//  Item.swift
//  TactusNota
//
//  Created by Jithin  Mathew on 12/1/22.
//

import SwiftUI

struct Item: Identifiable {

    let id = UUID()
    let url: URL

}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
