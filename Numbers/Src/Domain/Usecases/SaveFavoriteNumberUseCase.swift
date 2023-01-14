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
    @Inject var repository: NumberRepositoryType

    func execute(_ data: NumberEntity) throws {
        try repository.saveNumber(data)
    }
}

