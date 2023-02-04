//
//  Scenedelegate.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Foundation
import SwiftUI
import NumbersInjector

class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator = AppCoordinator()
    private var injector: NumbersInjector { .shared }

    func scene(_ scene: UIScene, willConnectTo
               session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        injector.apply(assemblies)
        coordinator.start(with: UIWindow(windowScene: scene))
        print("SceneDelegate is connected!")
    }
}
