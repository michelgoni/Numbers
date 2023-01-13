//
//  FavoritesView.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import SwiftUI

private extension String {
    static let favoriteTitle = "Saved favorites"
}

struct FavoritesView: View {
    private typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
    @EnvironmentObject private var viewModel: ViewModel
    @State private var showHidden = false
    
    var body: some View {
        NavigationView {

            VStack {
                List(viewModel.favoriteNumbers) {
                    FavoriteRow(number: $0)
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(
                AnyViewModel(
                    FavoritesViewModel()
                )
            )
    }
}
