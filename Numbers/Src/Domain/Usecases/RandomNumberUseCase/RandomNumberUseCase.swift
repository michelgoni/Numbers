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

    @Inject var repository: RandomNumberRepositoryType

    func execute() async throws -> NumberEntity {
        try await repository.fetchRandomNumber()
    }
}

