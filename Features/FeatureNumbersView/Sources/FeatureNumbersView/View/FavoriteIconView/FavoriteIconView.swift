//
//  FavoriteIconView.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import NumbersEx
import SwiftUI
import Shared

private extension Double {
    static let waitUntiFavoriteIsHandled = 0.5
}

private extension String {
    static let heartFill = "heart.fill"
    static let heart = "heart"
}

public struct FavoriteIconView: View {
    public typealias IconViewModel = AnyViewModel<FavoriteIconViewModel.Input, FavoriteIconViewModel.State>

    @State var isFavorite = false
    @ObservedObject var favoriteIconViewModel: IconViewModel
    @Binding var isLoading: Bool
    private let number: NumberRowViewEntity

    public init(isLoading: Binding<Bool>,
                favoriteIconViewModel: IconViewModel,
                number: NumberRowViewEntity) {
        self._isLoading = isLoading
        self.favoriteIconViewModel = favoriteIconViewModel
        self.number = number
    }

    public var body: some View {
        HStack {
            Spacer()
            ZStack {
                Button {
                    if !isLoading {
                        isLoading = true
                    }
                    favoriteIconViewModel.trigger(.modifyNumber)
                    favoriteIconViewModel.favoriteNumber ? favoriteIconViewModel.trigger(.save(number)) : favoriteIconViewModel.trigger(.delete(number))
                } label: {
                    isFavorite.favoriteImage
                        .foregroundColor(.black)
                }
                .show(!isLoading)
                ProgressView()
                    .show(isLoading)

            }
            .onReceive(favoriteIconViewModel.viewState, perform: viewState)
            .onAppear {
                favoriteIconViewModel.trigger(
                    .isFavorite(number.numberValue)
                )
            }
        }
    }

}

private extension FavoriteIconView {

    func viewState(_ state: FavoriteIconViewModel.ViewState?) {
        modifyLoading()

        switch state {
        case .favorite:
            isFavorite = true

        case .none, .error:
            isFavorite = false
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

