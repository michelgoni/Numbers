//
//  File.swift
//  
//
//  Created by Michel Goñi on 23/1/23.
//

import Foundation

protocol FetchNumberUseCaseType {

    func execute(_ number: String) async throws -> NumberRowViewEntity
}

final class FetchNumberUseCase: FetchNumberUseCaseType {

    private var repository: NumberRepositoryType

    init(repository: NumberRepositoryType) {
        self.repository = repository
    }

    func execute(_ number: String) async throws -> NumberRowViewEntity {
        try await repository.fetchNumber(number)
    }
}
