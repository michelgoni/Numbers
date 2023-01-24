//
//  RandomNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Combine
import Foundation

protocol FetchRandomNumberUseCaseType {

    func execute() async throws -> NumberEntity
}

final class FetchRandomNumberUseCaseImplm: FetchRandomNumberUseCaseType {

    private var repository: RandomNumberRepositoryType?

    init(repository: RandomNumberRepositoryType?) {
        self.repository = repository
    }

    func execute() async throws -> NumberEntity {
        try await repository!.fetchRandomNumber()
    }
}

