//
//  DeleteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation
import Shared


//sourcery: AutoMockable
public protocol DeleteFavoriteNumberUseCaseType {

    func execute(_ data: NumberRowViewEntity) throws -> [NumberRowViewEntity]
}
//sourcery: AutoMockable
public final class DeleteFavoriteNumberUseCase: DeleteFavoriteNumberUseCaseType {


    private var repository: NumberRepositoryType

    public init(repository: NumberRepositoryType) {
        self.repository = repository
    }


    public func execute(_ data: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        try repository.delete(data)
        
    }
}

