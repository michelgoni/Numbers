//
//  OnAppearOnce.swift
//  Numbers
//
//  Created by Michel Goñi on 9/1/23.
//

import SwiftUI

struct OnAppearOnce: ViewModifier {
    let action: () -> ()

    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared.toggle()
            action()
        }
    }
}
