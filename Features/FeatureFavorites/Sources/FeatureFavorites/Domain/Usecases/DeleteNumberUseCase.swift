//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation

public protocol DeleteFavoriteNumberUseCaseType {

    func execute(_ data: FavoriteNumberEntity) async throws -> [FavoriteNumberEntity]
}

public final class DeleteFavoriteNumberUseCase: DeleteFavoriteNumberUseCaseType {


    private var repository: FavoriteNumbersRepositoryType

     init(repository: FavoriteNumbersRepositoryType) {
        self.repository = repository
    }


    public func execute(_ data: FavoriteNumberEntity) async throws -> [FavoriteNumberEntity] {
        [FavoriteNumberEntity(numberValue: "", numberFact: "")]
    }
}

