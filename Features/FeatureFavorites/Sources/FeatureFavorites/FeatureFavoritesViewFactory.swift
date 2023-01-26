//
//  File.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import Foundation
import NumbersUI
import NumbersEx
import SwiftUI
import Shared

extension ViewFactory {
    
    func favoriteRow(_ favoriteEntity: NumberRowViewEntity) -> some View {
        make {
            FavoriteRow(
                number: favoriteEntity,
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
