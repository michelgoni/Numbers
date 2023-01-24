//
//  FeatureFavoritesAssembly.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Swinject


public struct FeatureFavoritesAssembly: Assembly {

    public init() {}


    public func assemble(container: Container) {
        container.registerUseCases()
    }
}

extension Container {
    func registerUseCases() {
        register(FavoritesNumberUseCaseType.self) { resolver in
            FavoritesNumberUseCase(
                repository: FavoritesRepositoryImplm()
            )

        }.inObjectScope(.container)

        register(DeleteFavoriteNumberUseCaseType.self) { resolver in
            DeleteFavoriteNumberUseCase(
                repository: FavoritesRepositoryImplm()
            )

        }.inObjectScope(.container)
    }
}
