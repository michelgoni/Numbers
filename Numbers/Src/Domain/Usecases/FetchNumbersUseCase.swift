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

//    @Injected(\.numbersProvider) var repository: NumberRepositoryType
    @Inject private var repository: NumberRepositoryType

    func execute() -> ResponsePublisher<[NumberEntity]> {
        repository.fetchNumbers()
    }

    func execute() async throws -> [NumberEntity] {
        try await repository.fetchNumbersAsync()
    }
}
