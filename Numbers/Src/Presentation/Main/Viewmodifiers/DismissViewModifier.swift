//
//  DismissViewModifier.swift
//  Numbers
//
//  Created by Michel Goñi on 15/1/23.
//

import SwiftUI

private extension String {
    static let dismiss = "x.circle.fill"
}

struct DismissButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        let view = ZStack {
            Color.clear
                .overlay(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
            content
        }
        return view
    }

    func what() {

    }
}
