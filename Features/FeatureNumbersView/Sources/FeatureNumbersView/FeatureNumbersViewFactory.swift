//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import NumbersUI
import NumbersEx
import SwiftUI


extension ViewFactory {

    func numberRow(_ number: NumberRowViewEntity) -> some View {

        make {
            NumberRow(number: number)
        }
    }

    func favoriteIconView(isLoading: Binding<Bool>,
                          number: NumberRowViewEntity) -> some View {

        make {
            FavoriteIconView(isLoading: isLoading,
                             favoriteIconViewModel: AnyViewModel(
                                FavoriteIconViewModel(
                                    isFavorite: false,
                                    favoritesUseCase: injector.get(IsfavoriteNumberUseCaseType.self),
                                    saveFavoritesUseCase: injector.get(SaveFavoriteNumberUseCaseType.self)
                                )
                             ),
                             number: number)
        }

    }
    
}
