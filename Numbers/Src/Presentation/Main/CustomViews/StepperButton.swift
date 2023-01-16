//
//  StepperButton.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import SwiftUI

private extension CGFloat {
    static let cornerRadius = 16.0
    static let systemSizeFont = 20.0
    static let isPressedTrue = 0.95
    static let isPressedFalse = 1.0
    static let height = 16.0
    static let width = 16.0
}

struct StepperButton: View {

    var action: () -> Void

    var imageName: String
    var body: some View {
        Button(
            action:
                {self.action() }) {
            buttonImage(name: imageName)
        }
        .buttonStyle(BorderlessButtonStyle())
    }

    private func buttonImage(name: String, color: Color = .mint) -> some View {
        return VStack {
            Image(systemName: name)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(color)
        }
        .frame(width: .width, height: .height)
    }
}
