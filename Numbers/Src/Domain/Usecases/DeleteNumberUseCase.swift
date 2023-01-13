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
    @Injected(\.numbersProvider) var repository: NumberRepositoryType

    func execute(_ data: NumberEntity) -> ResponsePublisher<[NumberEntity]> {
         repository.delete(data)
    }
}

private struct DeleteFavoriteNumberUseCaseKey: InjectionKey {
    static var currentValue: DeleteFavoriteNumberUseCaseType = DeleteFavoriteNumberUseCase()
}

extension InjectedValues {
    var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType {
        get { Self[DeleteFavoriteNumberUseCaseKey.self] }
        set { Self[DeleteFavoriteNumberUseCaseKey.self] = newValue }
    }
}
