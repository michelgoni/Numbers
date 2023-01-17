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
    private typealias ViewModel = AnyViewModel<RandomNumberViewModel.Input, RandomNumberViewModel.State>
    @State var progressValue: Float = 0.0
    @EnvironmentObject private var viewModel: ViewModel
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
                    viewModel.trigger(.minus)
                }, imageName: .minusCircle)
                RandomNumberProgressView(
                    progress: self.$progressValue)
                    .frame(width: 150.0,
                           height: 150.0)
                    .padding(60.0)
                StepperButton(action: {
                    viewModel.trigger(.plus)
                }, imageName: .plusCircle)

            }

            Text(verbatim: viewModel.number?.numberFact ?? "0")
                .font(.headline)
                .padding()
            Spacer()
        }
        .onAppear {[weak viewModel] in
            viewModel?.trigger(.randomNumber)
        }
        .onChange(of: viewModel.number) { newValue in
            guard let number = newValue else { return }
            self.progressValue = (number.numberValue as NSString).floatValue / 100.0
        }
    }
}
struct RandomNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
