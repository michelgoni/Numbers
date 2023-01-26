//
//  RandomNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Combine
import Foundation
import Shared

protocol FetchRandomNumberUseCaseType {

    func execute() async throws -> NumberRowViewEntity
}

final class FetchRandomNumberUseCaseImplm: FetchRandomNumberUseCaseType {

    private var repository: RandomNumberRepositoryType?

    init(repository: RandomNumberRepositoryType?) {
        self.repository = repository
    }

    func execute() async throws -> NumberRowViewEntity {
        try await repository!.fetchRandomNumber()
    }
}

