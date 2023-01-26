//
//  FetchWithOperationNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation
import Shared

protocol FetchWithOperationNumberUseCaseType {

    func execute(_ number: String) async throws -> NumberRowViewEntity
}

final class FetchWithOperationNumberUseCase: FetchWithOperationNumberUseCaseType {

    private var repository: NumberWithOperationRepositoryType?

    init(repository: NumberWithOperationRepositoryType?) {
        self.repository = repository
    }

    func execute(_ number: String) async throws -> NumberRowViewEntity {
        try await repository!.fetchNumber(number)
    }
}
