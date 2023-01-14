//
//  RemoteServiceAssembly.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import Swinject

struct RemoteServiceAssembly: Assembly {

    init() {}

    public func assemble(container: Container) {
        container.registerRemoteService()

    }
}

private extension Container {

    func registerRemoteService() {
        register(RemoteDSType.self) { resolver in
            RemoteDSImpl()
        }
    }
}

