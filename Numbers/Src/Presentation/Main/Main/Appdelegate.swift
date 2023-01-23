//
//  Appdelegate.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import SwiftUI
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {

    private var injector: Injector { .shared }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil,
                                                                     sessionRole: connectingSceneSession.role)
        injector.apply(assemblies)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

}

