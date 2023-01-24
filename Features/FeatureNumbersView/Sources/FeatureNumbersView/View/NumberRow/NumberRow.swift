//
//  NumberRow.swift
//  Numbers
//
//  Created by Michel Goñi on 26/12/22.
//
import Foundation
import NumbersEx
import SwiftUI

private extension CGFloat {
    static let width = 30.0
    static let height = 30.0
}

private extension String {
    static let circleFill = "p.circle.fill"
    static let circle = "p.circle"
}

struct NumberRow: View {
    public typealias ViewModel = AnyViewModel<NumberRowViewModel.Input, NumberRowViewModel.State>
    @ObservedObject public var viewModel: ViewModel
    @State private var isLoading: Bool
    let number: NumberRowViewEntity

    init(number: NumberRowViewEntity, viewModel: ViewModel) {
        self._isLoading = State(initialValue: false)
        self.number = number
        self.viewModel = viewModel
    }
    var body: some View {

        VStack {
            HStack {
                Text(number.numberValue)
                    .modifier(NumberModifier())
                Text(number.numberFact)
                    .padding()
            }
            HStack {
                primeButtonButton(number.isPrime)
                Spacer()
//                FavoriteIconView(
//                    isLoading: $isLoading,
//                    number: State(initialValue: number)
//                )
//                .environmentObject(
//                    AnyViewModel(
//                        FavoritesViewModel()
//                    )
//                )
//                .environmentObject(
//                    AnyViewModel(
//                        FavoriteIconViewModel(isFavorite: number.isFavorite)
//                    )
//                )

            }

            .padding()
        }
    }


    private func primeButtonButton(_ favorite: Bool) -> some View {

        return Button(action: {
            viewModel.trigger(.prime)
        }, label: {
            favorite.primeImage
        })
        .buttonStyle(PlainButtonStyle())
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
