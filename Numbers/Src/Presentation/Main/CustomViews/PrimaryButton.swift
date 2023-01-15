//
//  PrimaryButton.swift
//  Numbers
//
//  Created by Michel Goñi on 15/1/23.
//

import SwiftUI

private extension CGFloat {
    static let cornerRadius = 16.0
    static let systemSizeFont = 20.0
}

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .font(
                .system(size: .systemSizeFont,
                        weight: .bold,
                        design: .rounded)
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: .cornerRadius,
                    style: .continuous)
            )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
    }
}
