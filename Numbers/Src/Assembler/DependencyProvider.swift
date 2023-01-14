//
//  DependencyProvider.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import Swinject

class DependencyProvider {

    let container = Container()
    let assembler: Assembler

    init() {
        assembler = Assembler(
            [
                UseCasesAssembly(),
                RepositoryAssembly(),
                RemoteServiceAssembly(),
                LocalServiceAssembly()
            ],
            container: container
        )
    }
}
