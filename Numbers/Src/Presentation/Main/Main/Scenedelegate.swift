//
//  Scenedelegate.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Foundation
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?
    let coordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        coordinator.start(with: UIWindow(windowScene: scene))
        print("SceneDelegate is connected!")
    }
}
