//
//  AppCoordinator.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import SwiftUI

protocol AppCoordinatorType {

    func start(with window: UIWindow)
}

final class AppCoordinator: AppCoordinatorType {
    private var window: UIWindow?
    private lazy var factory: ViewFactory = { ViewFactory() }()

    func start(with window: UIWindow) {
        debugPrint("Starting app coordinator...")
        self.window = window
        self.window?.makeKeyAndVisible()
        setRoot()
    }
}

private extension AppCoordinator {
    func setRoot() {
        debugPrint("Setting Root...")
        self.window?.rootViewController = factory.view(.main).eraseToHostingController()
    }
}

 extension View {

     func eraseToHostingController() -> UIHostingController<Self> { .init(rootView: self) }
}
