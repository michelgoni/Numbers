//
//  Resolver.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Foundation
import Swinject

public class Resolver {
    public static let shared = Resolver()

    private var dependencyProvider = DependencyProvider()

    public func resolve<T>(_ type: T.Type) -> T {
        dependencyProvider.container.resolve(T.self)!
    }

}
