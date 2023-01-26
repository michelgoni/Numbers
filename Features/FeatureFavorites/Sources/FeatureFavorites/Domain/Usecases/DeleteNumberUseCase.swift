//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Shared

public protocol DeleteFavoriteNumberUseCaseType {

    func execute(_ data: NumberRowViewEntity) throws -> [NumberRowViewEntity]
}

public final class DeleteFavoriteNumberUseCase: DeleteFavoriteNumberUseCaseType {


    private var repository: FavoriteNumbersRepositoryType

     init(repository: FavoriteNumbersRepositoryType) {
        self.repository = repository
    }


    public func execute(_ data: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        try repository.delete(data)!
        
    }
}

