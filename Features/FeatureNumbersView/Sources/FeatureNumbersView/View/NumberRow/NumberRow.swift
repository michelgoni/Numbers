//
//  NumberRow.swift
//  Numbers
//
//  Created by Michel Goñi on 26/12/22.
//
import Foundation
import NumbersEx
import NumbersUI
import SwiftUI
import Shared
import Inject

private extension CGFloat {
    static let width = 30.0
    static let height = 30.0
}

private extension String {
    static let circleFill = "p.circle.fill"
    static let circle = "p.circle"
}

struct NumberRow: View {
    @State private var isLoading: Bool
    @ObservedObject private var iO = Inject.observer

    @Environment(\.viewFactory) private var viewFactory: ViewFactory
    let number: NumberRowViewEntity

    init(number: NumberRowViewEntity) {
        self._isLoading = State(initialValue: false)
        self.number = number

    }
    var body: some View {

        VStack {
            HStack {
                Text("\(number.numberValue)")
                    .modifier(NumberModifier())
                Text(number.numberFact)
                    .font(.body)

            }
            HStack {
                Spacer()
                number.isPrime.primeImage
                Spacer()
                viewFactory.favoriteIconView(isLoading: $isLoading,
                                             number: number)
                Spacer()
            }
            .padding()
        }
        .enableInjection()
    }


}

private extension Bool {

    var primeImage: Image {
        switch self {
        case true:
            return Image(systemName: .circleFill)
        case false:
            return Image(systemName: .circle)
        }
    }
}

//struct NumberRow_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberRow(
//            number: NumberRowViewEntity(numberValue: 1, numberFact: "is the number for this preview", isPrime: false)
//        )
//    }
//}

