//
//  DeleteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation

public protocol DeleteFavoriteNumberUseCaseType {

    func execute(_ data: NumberRowViewEntity) async throws -> [NumberRowViewEntity]
}

public final class DeleteFavoriteNumberUseCase: DeleteFavoriteNumberUseCaseType {


    private var repository: NumberRepositoryType

    public init(repository: NumberRepositoryType) {
        self.repository = repository
    }


    public func execute(_ data: NumberRowViewEntity) async throws -> [NumberRowViewEntity] {
        [NumberRowViewEntity(numberValue: "", numberFact: "", isPrime: false)]
    }
}

