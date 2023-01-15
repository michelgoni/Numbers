//
//  ProgressView.swift
//  Numbers
//
//  Created by Michel Goñi on 15/1/23.
//

import SwiftUI

struct RandomNumberProgressView: View {
    @Binding var progress: Float
    @State private var scale = 1.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1)))
                    .stroke(
                        style: StrokeStyle(lineWidth: 20.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear(duration: 1), value: scale)
            Text(String(format: "%.0f", min(self.progress, 1)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}
