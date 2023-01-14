//
//  ViewFactory.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
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
