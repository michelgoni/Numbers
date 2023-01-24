//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import NumbersUI
import NumbersEx
import NumbersInjector
import SwiftUI


extension ViewFactory {

    func numberRow(_ number: NumberRowViewEntity) -> some View {

        make {
            NumberRow(number: number,
                      viewModel: AnyViewModel(
                        NumberRowViewModel(favoritesUseCase: injector.get(FetchNumbersUseCaseType.self),
                                           saveFavoritesUseCase: injector.get(SaveFavoriteNumberUseCaseType.self), deleteFavoritesUseCase: injector.get(DeleteFavoriteNumberUseCaseType.self)
                                          )
                      )
            )
        }
    }
    
}
