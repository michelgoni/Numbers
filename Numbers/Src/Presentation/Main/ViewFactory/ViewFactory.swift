//
//  ViewFactory.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import FeatureNumbersView
import FeatureFavorites
import NumbersEx
import NumbersUI
import SwiftUI


public extension ViewFactory {

    func getMainView() -> some View {
        make {
            MainView()
        }
    }

    func getNumbersMainView() -> some View {
        make {
            NumbersView(
                viewModel: AnyViewModel(
                    NumbersViewModel(
                        numbersUseCase: injector.get(FetchNumbersUseCaseType.self),
                        numberUseCase: injector.get(FetchNumberUseCaseType.self))
                )
            )
        }
    }

    func getNumbersFavoritesView() -> some View {
        make {
            FavoritesView(
                viewModel: AnyViewModel(
                    FavoritesViewModel(
                        favoritesUseCase: injector.get(FavoritesNumberUseCaseType.self),
                        deleteFavoritesUseCase: injector.get(DeleteFavoriteNumberUseCaseType.self)
                    )
                )
            )
        }
    }
}
