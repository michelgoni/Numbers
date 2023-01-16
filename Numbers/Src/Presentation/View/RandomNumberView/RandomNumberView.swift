//
//  RandomNumberView.swift
//  Numbers
//
//  Created by Michel Goñi on 15/1/23.
//

import SwiftUI

private extension String {
    static let circleFill = "x.circle.fill"
    static let plusCircle = "plus.circle.fill"
    static let minusCircle = "minus.circle.fill"
}

struct RandomNumberView: View {
    @State var progressValue: Float = 0.0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: .circleFill)
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding()
                }
            }
            HStack {
                StepperButton(action: {

                }, imageName: .plusCircle)
                RandomNumberProgressView(progress: self.$progressValue)
                    .frame(width: 150.0,
                           height: 150.0)
                    .padding(60.0)
                StepperButton(action: {

                }, imageName: .minusCircle)

            }

            Text(verbatim: "Simple text for the result")
                .font(.headline)
            Spacer()
        }

    }
}
struct RandomNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
