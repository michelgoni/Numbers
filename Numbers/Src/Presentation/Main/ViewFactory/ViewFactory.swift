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


private extension String {
    static let numbersImage = "list.number"
    static let favsImage = "number"
}


public extension ViewFactory {
    func getTabs() -> some View {

        make {
            TabView {
                NumbersView(
                    viewModel: AnyViewModel(
                        NumbersViewModel(
                            numbersUseCase: injector.get(FetchNumbersUseCaseType.self),
                            numberUseCase: injector.get(FetchNumberUseCaseType.self))
                    )
                )
                .tabItem {
                    Label("Numbers",
                          systemImage:. numbersImage)
                }
                FavoritesView(
                    viewModel: AnyViewModel(
                        FavoritesViewModel(
                            favoritesUseCase: injector.get(FavoritesNumberUseCaseType.self),
                            deleteFavoritesUseCase: injector.get(DeleteFavoriteNumberUseCaseType.self)
                        )
                    )
                )
                .tabItem {
                    Label("Favorites",
                          systemImage: .favsImage)
                }
            }

        }
    }
}
