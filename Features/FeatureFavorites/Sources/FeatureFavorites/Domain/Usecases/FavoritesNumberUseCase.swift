//
//  FavoritesNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation
import Shared

//sourcery: AutoMockable
public protocol FavoritesNumberUseCaseType {
    func execute() throws -> [NumberRowViewEntity]?
}

//sourcery: AutoMockable
public final class FavoritesNumberUseCase: FavoritesNumberUseCaseType {
    
    private var repository: FavoriteNumbersRepositoryType?

    init(repository: FavoriteNumbersRepositoryType?) {
        self.repository = repository
    }

    public func execute() throws -> [NumberRowViewEntity]? {
        try repository?.fetchFavoritesList()
    }
}

