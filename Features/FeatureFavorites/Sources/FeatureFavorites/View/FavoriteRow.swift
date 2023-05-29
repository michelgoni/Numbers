//
//  FavoriteRow.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import NumbersEx
import SwiftUI
import Shared

private extension CGFloat {
    static let deleteButtonSize = 30.0
}

public struct FavoriteRow: View {
    let number: NumberRowViewEntity
    public typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
    @ObservedObject var viewModel: ViewModel

    public init(number: NumberRowViewEntity, viewModel: ViewModel) {
        self.number = number
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            HStack {
                Text(String(number.numberValue))
                .modifier(
                    NumberModifier()
                )
                Text(
                    number.numberFact)
                .padding()
            }
            HStack {
                Spacer()
                deleteButton()
                    .frame(
                        width: .deleteButtonSize,
                        height: .deleteButtonSize)
            }
            .padding()

        }
    }

    private func deleteButton() -> some View {

        return Button(action: {
            viewModel.trigger(.delete(number))
        }, label: {
            Image(systemName: "trash.fill")
        })
        .buttonStyle(PlainButtonStyle())
    }
}
