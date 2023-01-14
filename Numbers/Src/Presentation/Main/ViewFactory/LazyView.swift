//
//  LazyView.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import SwiftUI

struct LazyView<Content: View>: View {
    private let build: () -> Content

    public init(@ViewBuilder build: @escaping () -> Content) {
        self.build = build
    }

    public var body: some View {
        build()
    }
}
