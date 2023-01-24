//
//  FavoritesNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation


public protocol FavoritesNumberUseCaseType {
    func execute() async throws -> [FavoriteNumberEntity]
}

public final class FavoritesNumberUseCase: FavoritesNumberUseCaseType {
    
    private var repository: FavoriteNumbersRepositoryType?

    init(repository: FavoriteNumbersRepositoryType?) {
        self.repository = repository
    }

    public func execute() async throws -> [FavoriteNumberEntity] {
       []
    }
}

