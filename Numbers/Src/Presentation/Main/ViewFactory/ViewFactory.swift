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


struct ViewFactory {
    var injector: Injector { .shared }
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

enum ViewType {
    case main
}
