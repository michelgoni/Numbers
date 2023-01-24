//
//  AppCoordinator.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import NumbersUI
import SwiftUI


protocol AppCoordinatorType {

    func start(with window: UIWindow)
}

final class AppCoordinator: AppCoordinatorType {
    private var window: UIWindow?
    private lazy var viewFactory: ViewFactory = { ViewFactory() }()

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
        self.window?.rootViewController = viewFactory.getTabs().eraseToHostingController()
    }
}

 extension View {

     func eraseToHostingController() -> UIHostingController<Self> { .init(rootView: self) }
}
