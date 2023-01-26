//
//  FeatureNumbersAssembly.swift
//  
//
//  Created by Michel Goñi on 23/1/23.
//

import Foundation
import Swinject


public struct FeatureNumbersAssembly: Assembly {

    public init() {}


    public func assemble(container: Container) {
        container.registerUseCases()
        container.registerRepository()
        container.registerRemoteService()
        container.registerLocalService()
    }

}

extension Container {

    func registerUseCases() {
        register(FetchNumbersUseCaseType.self) { resolver in
            FetchNumbersUseCase(repository: NumberRepositoryImplm(
                localDS: resolver.resolve(
                    FetchNumberLocalDSType.self),
                remoteDS: resolver.resolve(
                    FetchNumberRemoteDSType.self))
            )
        }.inObjectScope(.container)

        register(FetchNumberUseCaseType.self) { resolver in
            FetchNumberUseCase(repository: NumberRepositoryImplm(
                localDS: resolver.resolve(
                    FetchNumberLocalDSType.self),
                remoteDS: resolver.resolve(
                    FetchNumberRemoteDSType.self))
            )
        }.inObjectScope(.container)

        register(SaveFavoriteNumberUseCaseType.self) { resolver in
            SaveFavoriteNumberUseCase(
                repository: NumberRepositoryImplm(
                    localDS: resolver.resolve(
                        FetchNumberLocalDSType.self),
                    remoteDS: resolver.resolve(FetchNumberRemoteDSType.self)
                )
            )
        }.inObjectScope(.container)

        register(DeleteFavoriteNumberUseCaseType.self) { resolver in
            DeleteFavoriteNumberUseCase(
                repository: NumberRepositoryImplm(
                    localDS: resolver.resolve(
                        FetchNumberLocalDSType.self),
                    remoteDS: resolver.resolve(FetchNumberRemoteDSType.self)
                )
            )
        }.inObjectScope(.container)

        register(IsfavoriteNumberUseCaseType.self) { resolver in
            IsfavoriteNumberUseCase(
                repository: NumberRepositoryImplm(
                    localDS: resolver.resolve(
                        FetchNumberLocalDSType.self),
                    remoteDS: resolver.resolve(FetchNumberRemoteDSType.self)
                )
            )
        }.inObjectScope(.container)

        register(FetchRandomNumberUseCaseType.self) { resolver in
            FetchRandomNumberUseCaseImplm(
                repository: resolver.resolve(RandomNumberRepositoryType.self)
            )
        }
        .inObjectScope(.container)

        register(FetchWithOperationNumberUseCaseType.self) { resolver in
            FetchWithOperationNumberUseCase(repository: resolver.resolve(NumberWithOperationRepositoryType.self))
        }
        .inObjectScope(.container)
    }

    func registerRepository() {
        register(NumberRepositoryType.self) { resolver in
            NumberRepositoryImplm(
                localDS: resolver.resolve(FetchNumberLocalDSType.self),
                remoteDS: resolver.resolve(FetchNumberRemoteDSType.self)
            )
        }.inObjectScope(.container)

        register(RandomNumberRepositoryType.self) { resolver in
            RandomNumberRepositoryImplm(remoteDS: resolver.resolve(RemoteDSRandomNumberType.self),
                                        localDS: resolver.resolve(FetchNumberLocalDSType.self)
            )
        }.inObjectScope(.container)

        register(NumberWithOperationRepositoryType.self) { resolver in
            NumberWithOperationRepositoryImplm(remoteDS: resolver.resolve(RemoteDSRandomNumberType.self),
                                               localDS: resolver.resolve(FetchNumberLocalDSType.self))
        }.inObjectScope(.container)
    }

    func registerRemoteService() {
        register(FetchNumberRemoteDSType.self) { _ in
            FetchNumberRemoteDSImplm()
        }.inObjectScope(.container)

        register(RemoteDSRandomNumberType.self) { _ in
            RemoteDSRandomNumber()
        }.inObjectScope(.container)
    }

    func registerLocalService() {
        register(FetchNumberLocalDSType.self) { _ in
            FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard)
        }.inObjectScope(.container)

        register(FetchNumberLocalDSType.self.self) { _ in
            FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard)
        }.inObjectScope(.container)
    }
}
