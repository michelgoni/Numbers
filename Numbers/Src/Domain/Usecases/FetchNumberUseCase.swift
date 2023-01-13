//
//  FetchNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 4/1/23.
//

import Foundation

protocol FetchNumberUseCaseType {

    func execute(_ number: String) -> ResponsePublisher<[NumberEntity]>
}

final class FetchNumberUseCase: FetchNumberUseCaseType {
    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute(_ number: String) -> ResponsePublisher<[NumberEntity]> {
        repository.fetchNumber(number)
    }
}

private struct NumberUseCaseKey: InjectionKey {
    static var currentValue: FetchNumberUseCaseType = FetchNumberUseCase()
}

extension InjectedValues {
    var numberUseCase: FetchNumberUseCaseType {
        get { Self[NumberUseCaseKey.self] }
        set { Self[NumberUseCaseKey.self] = newValue }
    }
}
