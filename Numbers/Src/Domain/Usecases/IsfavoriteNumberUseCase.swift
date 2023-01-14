//
//  IsfavoriteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//

import Foundation

protocol IsfavoriteNumberUseCaseType {

    func execute(_ number: String) -> Bool
}

final class IsfavoriteNumberUseCase: IsfavoriteNumberUseCaseType {
    @Inject private var repository: NumberRepositoryType

    func execute(_ number: String) -> Bool {
        repository.isFavorite(number)
    }
}

