//
//  FetchWithOperationNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation

protocol FetchWithOperationNumberUseCaseType {

    func execute(_ number: String) async throws -> NumberEntity
}

final class FetchWithOperationNumberUseCase: FetchWithOperationNumberUseCaseType {

    @Inject var repository: NumberWithOperationRepositoryType

    func execute(_ number: String) async throws -> NumberEntity {
        try await repository.fetchNumber(number)
    }
}
