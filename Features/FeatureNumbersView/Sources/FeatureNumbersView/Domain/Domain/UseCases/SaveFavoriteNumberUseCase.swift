//
//  SaveFavoriteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation


public protocol SaveFavoriteNumberUseCaseType {
    func execute(_ data: NumberRowViewEntity) throws
}

final class SaveFavoriteNumberUseCase: SaveFavoriteNumberUseCaseType {
    private var repository: NumberRepositoryType

    init(repository: NumberRepositoryType) {
        self.repository = repository
    }

    public func execute(_ data: NumberRowViewEntity) throws {

    }
}

