//
//  DeleteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 31/12/22.
//

import Foundation

protocol DeleteFavoriteNumberUseCaseType {

    func execute(_ data: NumberEntity) -> ResponsePublisher<[NumberEntity]>
}

final class DeleteFavoriteNumberUseCase: DeleteFavoriteNumberUseCaseType {
    @Inject var repository: NumberRepositoryType

    func execute(_ data: NumberEntity) -> ResponsePublisher<[NumberEntity]> {
         repository.delete(data)
    }
}

