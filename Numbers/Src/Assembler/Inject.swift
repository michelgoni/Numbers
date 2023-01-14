//
//  Inject.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import Foundation

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}
