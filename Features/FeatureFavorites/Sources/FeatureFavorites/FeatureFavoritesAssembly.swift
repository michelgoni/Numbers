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
        container.registerRepository()
        container.registerLocalDS()
    }
}

extension Container {
    func registerUseCases() {
        register(FavoritesNumberUseCaseType.self) { resolver in
            FavoritesNumberUseCase(
                repository: FavoritesRepositoryImplm(
                    localDS: resolver.resolve(FetchNumberLocalDSType.self)
                                                    )
            )

        }.inObjectScope(.container)

        register(DeleteFavoriteNumberUseCaseType.self) { resolver in
            DeleteFavoriteNumberUseCase(
                repository: FavoritesRepositoryImplm(
                    localDS: resolver.resolve(
                        FetchNumberLocalDSType.self)
                )
            )

        }.inObjectScope(.container)
    }

    func registerRepository() {
        register(FavoriteNumbersRepositoryType.self.self) { resolver in
            FavoritesRepositoryImplm(
                localDS: resolver.resolve(FetchNumberLocalDSType.self)
            )

        }.inObjectScope(.container)
    }

    func registerLocalDS() {
        register(FetchNumberLocalDSType.self) { _ in
            FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard)

        }.inObjectScope(.container)
    }
}
