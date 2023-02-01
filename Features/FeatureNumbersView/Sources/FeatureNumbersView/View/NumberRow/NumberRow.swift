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
                    .padding()
            }
            HStack {
                number.isPrime.primeImage
                Spacer()
                viewFactory.favoriteIconView(isLoading: $isLoading,
                                             number: number)
            }
            .padding()
        }
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
//            number: NumberEntity(
//                isFavorite: true,
//                isPrime: true,
//                numberValue: "1",
//                numberFact: " is a favorite number wich was previously saved")
//        )
//        .environmentObject(
//            AnyViewModel(
//                FavoritesViewModel()
//            )
//        )
//    }
//}
//
