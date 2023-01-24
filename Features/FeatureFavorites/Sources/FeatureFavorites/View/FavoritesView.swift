//
//  FavoritesView.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import SwiftUI
import NumbersEx

private extension String {
    static let favoriteTitle = "Saved favorites"
}

@available(iOS 13.0, *)
public struct FavoritesView: View {
    public typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
    @ObservedObject private var viewModel: ViewModel
    @State private var showHidden = false

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {

            VStack {
                List(viewModel.favoriteNumbers) {
                    Text(verbatim: $0.numberValue)
                }
                .modifier(TitleModifier(title: .favoriteTitle))
            }
            .overlay(EmptyView()
                .show(showHidden)
            )
            .onReceive(viewModel.viewState, perform: viewState)
            .onAppear{ [weak viewModel] in
                viewModel?.trigger(.favoritesList)
            }
        }
    }
}

private extension FavoritesView {

    func viewState(_ viewState: FavoritesViewModel.ViewState?) {
        switch viewState {
        case .emptyFavorites:
            showHidden = true
        case .favorites:
            showHidden = false
        default: break
        }
    }
}
//
//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView()
//            .environmentObject(
//                AnyViewModel(
//                    FavoritesViewModel()
//                )
//            )
//    }
//}

