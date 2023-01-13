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
    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute(_ number: String) -> Bool {
        repository.isFavorite(number)
    }
}


private struct IsfavoriteNumberUseCaseKey: InjectionKey {
    static var currentValue: IsfavoriteNumberUseCaseType = IsfavoriteNumberUseCase()
}

extension InjectedValues {
    var isfavoriteNumberUseCase: IsfavoriteNumberUseCaseType {
        get { Self[IsfavoriteNumberUseCaseKey.self] }
        set { Self[IsfavoriteNumberUseCaseKey.self] = newValue }
    }
}
