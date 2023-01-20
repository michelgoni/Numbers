//
//  File.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation

protocol FetchNumbersUseCaseType {

    func execute() async throws -> [NumberRowViewEntity]
}

final class FetchNumbersUseCase: FetchNumbersUseCaseType {

    private var repository: NumberRepositoryType

    init(repository: NumberRepositoryType) {
        self.repository = repository
    }

    func execute() async throws -> [NumberRowViewEntity] {
        try await repository.fetchNumbers()
    }
}

