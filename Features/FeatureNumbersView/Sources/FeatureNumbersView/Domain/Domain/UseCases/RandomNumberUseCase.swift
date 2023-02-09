//
//  RandomNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Combine
import Foundation
import Shared

public protocol FetchRandomNumberUseCaseType {

    func execute() async throws -> NumberRowViewEntity
}

public final class FetchRandomNumberUseCaseImplm: FetchRandomNumberUseCaseType {

    var repository: RandomNumberRepositoryType?

    public init(repository: RandomNumberRepositoryType?) {
        self.repository = repository
    }

    public func execute() async throws -> NumberRowViewEntity {
        try await repository!.fetchRandomNumber()
    }
}

