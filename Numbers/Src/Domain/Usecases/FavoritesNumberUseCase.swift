//
//  FavoritesNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation

protocol FetchFavoritesNumberUseCaseType {
    func execute() -> ResponsePublisher<[NumberEntity]>
}

final class FavoritesNumberUseCase: FetchFavoritesNumberUseCaseType {
    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute() -> ResponsePublisher<[NumberEntity]> {
        repository.fetchSavedNumbers()
    }
}


private struct FavoritesUseCaseKey: InjectionKey {
    static var currentValue: FetchFavoritesNumberUseCaseType = FavoritesNumberUseCase()
}

extension InjectedValues {
    var favoritesUseCase: FetchFavoritesNumberUseCaseType {
        get { Self[FavoritesUseCaseKey.self] }
        set { Self[FavoritesUseCaseKey.self] = newValue }
    }
}
