//
//  DependencyProvider.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import Swinject

//class DependencyProvider {
//
//    let container = Container()
//    let assembler: Assembler
//
//    init() {
//        assembler = Assembler(
//            [
//                UseCasesAssembly(),
//                RepositoryAssembly(),
//                RemoteServiceAssembly(),
//                LocalServiceAssembly()
//            ],
//            container: container
//        )
//    }
//}
//
//public class Injector {
//    public static let shared = Injector()
//    private lazy var assembler = Assembler()
//    private lazy var container = assembler.resolver as? Container
//    private lazy var resolver = container?.synchronize()
//
//    private init() {}
//
//    func apply(_ assemblies: [Assembly]) {
//        assembler.apply(assemblies: assemblies)
//    }
//}
//
//public extension Injector {
//    func get<Service>(_ service: Service.Type) -> Service? {
//        resolver?.resolve(service)
//    }
//}
