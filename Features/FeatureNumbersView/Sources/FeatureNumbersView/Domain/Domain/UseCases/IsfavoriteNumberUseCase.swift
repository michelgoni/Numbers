//
//  IsfavoriteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//

import Foundation

//sourcery: AutoMockable
public protocol IsfavoriteNumberUseCaseType {

    func execute(_ number: String) -> Bool
}

//sourcery: AutoMockable
public final class IsfavoriteNumberUseCase: IsfavoriteNumberUseCaseType {
    private  var repository: NumberRepositoryType

    init(repository: NumberRepositoryType) {
        self.repository = repository
    }

    public func execute(_ number: String) -> Bool {
        repository.isFavorite(number)
    }
}

