//
//  ViewFactory.swift
//  Numbers
//
//  Created by Michel Goñi on 14/1/23.
//

import Foundation
import NumbersEx
import FeatureNumbersView
import SwiftUI
import Swinject

private extension String {
    static let numbersImage = "list.number"
    static let favsImage = "number"
}


public struct ViewFactory {
    var injector: Injector { .shared }
    init() {}

}

public extension ViewFactory {

    func make<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        LazyView(build: content)
    }
}


public extension ViewFactory {
    func view(_ type: ViewType) -> some View {

        make {
            TabView {
                NumbersView(
                    viewModel: AnyViewModel(
                        NumbersViewModel(
                            numbersUseCase: injector.get(FetchNumbersUseCaseType.self),
                            numberUseCase: injector.get(FetchNumberUseCaseType.self))
                    )
                )
                .tabItem {
                    Label("Numbers",
                          systemImage:. numbersImage)
                }
            }
        }

//
//        make {
//
//            TabView {
//                NumbersView(
//                    viewModel: AnyViewModel(
//                        NumbersViewModel(
//                            numbersUseCase: injector.get(
//                                FetchNumbersUseCaseType.self),
//                            numberUseCase: injector.get(FetchNumberUseCaseType.self)
//                        )
//                    )
//                )
//                .tabItem {
//                    Label("Numbers",
//                          systemImage:. numbersImage)
//                }
//
//
//                //                    FavoritesView()
//                //                        .environmentObject(
//                //                            AnyViewModel(
//                //                                FavoritesViewModel()
//                //                            )
//                //                        )
//                //                        .tabItem {
//                //                            Label("Saved Numbers",
//                //                                  systemImage: .favsImage)
//                //                        }
//            }
//
//        }
    }
}

public enum ViewType {
    case main
}

struct ViewFactoryKey: EnvironmentKey {
    static let defaultValue: ViewFactory = .init()
}

public extension EnvironmentValues {
    var viewFactory: ViewFactory { self[ViewFactoryKey.self] }
}

