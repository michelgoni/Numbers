//
//  ShowModifier.swift
//  Numbers
//
//  Created by Michel Goñi on 19/1/23.
//

import SwiftUI

struct ShowModifier: ViewModifier {
    var active: Bool

    func body(content: Content) -> some View {
        if active {
            content
        }
    }
}
