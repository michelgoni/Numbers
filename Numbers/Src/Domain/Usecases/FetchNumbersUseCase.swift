//
//  FetchNumbersUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Combine
import Foundation

protocol FetchNumbersUseCaseType {

    func execute() -> ResponsePublisher<[NumberEntity]>
    func execute() async throws -> [NumberEntity]
}

final class FetchNumbersUseCase: FetchNumbersUseCaseType {

    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute() -> ResponsePublisher<[NumberEntity]> {
        repository.fetchNumbers()
    }

    func execute() async throws -> [NumberEntity] {
        try await repository.fetchNumbersAsync()
    }
}

private struct NumberUseCaseKey: InjectionKey {
    static var currentValue: FetchNumbersUseCaseType = FetchNumbersUseCase()
}

extension InjectedValues {
    var numbersUseCase: FetchNumbersUseCaseType {
        get { Self[NumberUseCaseKey.self] }
        set { Self[NumberUseCaseKey.self] = newValue }
    }
}
