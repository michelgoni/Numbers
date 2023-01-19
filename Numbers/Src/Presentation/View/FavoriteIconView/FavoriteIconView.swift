//
//  FavoriteIconView.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//

import Foundation
import SwiftUI

private extension Double {
    static let waitUntiFavoriteIsHandled = 0.5
}

private extension String {
    static let heartFill = "heart.fill"
    static let heart = "heart"
}

struct FavoriteIconView: View {
    
    @State var number: NumberEntity
    @Binding private var isLoading: Bool
    private typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
    private typealias IconViewModel = AnyViewModel<FavoriteIconViewModel.Input, FavoriteIconViewModel.State>
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var favoriteIconViewModel: IconViewModel
    
    init(isLoading: Binding<Bool>, number: State<NumberEntity>) {
        self._isLoading = isLoading
        self._number = number
    }
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Button {
                    if !isLoading {
                        isLoading = true
                    }
                    favoriteIconViewModel.trigger(.modifyNumber)
                    favoriteIconViewModel.favoriteNumber ? viewModel.trigger(.save(number)) : viewModel.trigger(.delete(number))
                } label: {
                    number.isFavorite.favoriteImage
                        .foregroundColor(.black)
                }
                .show(!isLoading)
                ProgressView()
                    .show(isLoading)
                    .onReceive(favoriteIconViewModel.viewState, perform: viewState)
                    .onAppear {
                        favoriteIconViewModel.trigger(
                            .isFavorite(number.numberValue)
                        )
                    }
            }
        }
    }
    
}

private extension FavoriteIconView {

    func viewState(_ state: FavoriteIconViewModel.ViewState?) {
        modifyLoading()

        switch state {
        case .favorite:
            number.isFavorite = true

        case .none:
            number.isFavorite = false
        }
    }

    func modifyLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .waitUntiFavoriteIsHandled) {
            isLoading = false
        }
    }
}


private extension Bool {
    var favoriteImage: Image {
        switch self {
        case true:
            return Image(systemName: .heartFill)
        case false:
            return Image(systemName: .heart)
        }
    }
}

