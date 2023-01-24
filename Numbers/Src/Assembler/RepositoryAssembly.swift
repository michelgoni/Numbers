////
////  RepositoryAssembly.swift
////  Numbers
////
////  Created by Michel Goñi on 14/1/23.
////
//
//import Swinject
//
//struct RepositoryAssembly: Assembly {
//
//    init() {}
//
//    public func assemble(container: Container) {
//        container.registerRepository()
//
//    }
//}
//
//private extension Container {
//
//    func registerRepository() {
//        register(NumberRepositoryType.self) { resolver in
//            NumbersRepository()
//        }
//
//        register(RandomNumberRepositoryType.self) { resolver in
//            RandomNumberRepositoryImplm()
//        }
//
//        register(NumberWithOperationRepositoryType.self) { resolver in
//            NumberWithOperationRepositoryImplm()
//        }
//    }
//}
