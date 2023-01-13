//
//  NumbersAssembly.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Foundation
import SwiftUI

private extension String {
    static let numbersImage = "list.number"
    static let favsImage = "number"
}


struct ViewFactory {

    init() {}
}

extension ViewFactory {

    func make<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        LazyView(build: content)
    }
}


extension ViewFactory {
    func view(_ type: ViewType) -> some View {
        
        make {
            switch type {
            case .main:
                TabView {
                    NumbersView()
                        .environmentObject(
                            AnyViewModel(
                                NumbersViewModel()
                            )
                        )
                        .tabItem {
                            Label("Numbers",
                                  systemImage:. numbersImage)
                        }

                    FavoritesView()
                        .environmentObject(
                            AnyViewModel(
                                FavoritesViewModel()
                            )
                        )
                        .tabItem {
                            Label("Saved Numbers",
                                  systemImage: .favsImage)
                        }
                }
            }

        }
    }
}

enum ViewType {
    case main
}

public struct LazyView<Content: View>: View {
    private let build: () -> Content

    public init(@ViewBuilder build: @escaping () -> Content) {
        self.build = build
    }

    public var body: some View {
        build()
    }

}
