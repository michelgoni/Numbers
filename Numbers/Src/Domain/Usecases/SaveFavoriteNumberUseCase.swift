//
//  SaveFavoriteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation


protocol SaveFavoriteNumberUseCaseType {
    func execute(_ data: NumberEntity) throws
}

final class SaveFavoriteNumberUseCase: SaveFavoriteNumberUseCaseType {
    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute(_ data: NumberEntity) throws {
        try repository.saveNumber(data)
    }
}

private struct SaveFavoriteNumberUseCaseKey: InjectionKey {
    static var currentValue: SaveFavoriteNumberUseCaseType = SaveFavoriteNumberUseCase()
}

extension InjectedValues {
    var saveFavoritesUseCase: SaveFavoriteNumberUseCaseType {
        get { Self[SaveFavoriteNumberUseCaseKey.self] }
        set { Self[SaveFavoriteNumberUseCaseKey.self] = newValue }
    }
}
