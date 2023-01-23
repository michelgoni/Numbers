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
    }

    func registerRepository() {
        register(NumberRepositoryType.self) { resolver in
            NumberRepositoryImplm(
                localDS: resolver.resolve(FetchNumberLocalDSType.self),
                remoteDS: resolver.resolve(FetchNumberRemoteDSType.self)
            )
        }
    }

    func registerRemoteService() {
        register(FetchNumberRemoteDSType.self) { _ in
            FetchNumberRemoteDSImplm()
        }
    }

    func registerLocalService() {
        register(FetchNumberLocalDSType.self) { _ in
            FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard)
        }
    }
}
