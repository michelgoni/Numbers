//
//  File.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import Shared

//sourcery: AutoMockable
public protocol FetchNumbersUseCaseType {

    func execute() async throws -> [NumberRowViewEntity]
}

//sourcery: AutoMockable
public final class FetchNumbersUseCase: FetchNumbersUseCaseType {

    private var repository: NumberRepositoryType

    public init(repository: NumberRepositoryType) {
        self.repository = repository
    }

    public func execute() async throws -> [NumberRowViewEntity] {
        try await repository.fetchNumbers()
    }
}

