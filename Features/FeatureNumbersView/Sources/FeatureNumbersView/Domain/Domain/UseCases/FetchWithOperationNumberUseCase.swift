//
//  FetchWithOperationNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation
import Shared

public protocol FetchWithOperationNumberUseCaseType {

    func execute(_ number: Int) async throws -> NumberRowViewEntity
}

public final class FetchWithOperationNumberUseCase: FetchWithOperationNumberUseCaseType {

     var repository: NumberWithOperationRepositoryType?

    public init(repository: NumberWithOperationRepositoryType?) {
        self.repository = repository
    }

    public func execute(_ number: Int) async throws -> NumberRowViewEntity {
        try await repository!.fetchNumber(number)
    }
}
