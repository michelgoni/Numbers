////
////  LocalServiceAssembly.swift
////  Numbers
////
////  Created by Michel Goñi on 14/1/23.
////
//import Foundation
//import Swinject
//
//struct LocalServiceAssembly: Assembly {
//
//    init() {}
//
//    public func assemble(container: Container) {
//        container.registerLocalService()
//
//    }
//}
//
//private extension Container {
//
//    func registerLocalService() {
//        register(UserDefaultsDataSourceType.self) { resolver in
//            UserDefaultDataSource(userDefaults: UserDefaults.standard)
//        }
//    }
//}
