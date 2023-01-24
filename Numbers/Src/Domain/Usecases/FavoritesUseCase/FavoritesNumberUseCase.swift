//
//  FavoritesNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation

protocol FavoritesNumberUseCaseType {
    func execute() -> ResponsePublisher<[NumberEntity]>
}

final class FavoritesNumberUseCase: FavoritesNumberUseCaseType {
    
    private var repository: NumberRepositoryType?

    init(repository: NumberRepositoryType?) {
        self.repository = repository
    }

    func execute() -> ResponsePublisher<[NumberEntity]> {
        repository!.fetchSavedNumbers()
    }
}

