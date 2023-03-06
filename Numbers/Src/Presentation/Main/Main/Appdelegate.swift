//
//  Appdelegate.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func applicationDidFinishLaunching(_ application: UIApplication) {
#if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
#endif
    }

    func application(_ application: UIApplication,
                     configurationForConnecting
                     connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil,
                                                                     sessionRole: connectingSceneSession.role)

        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
