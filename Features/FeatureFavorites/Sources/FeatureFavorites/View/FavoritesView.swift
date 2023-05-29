//
//  FavoritesView.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import NumbersEx
import Shared
import SwiftUI
import NumbersUI

private extension String {
    static let favoriteTitle = "Saved favorites"
}

@available(iOS 13.0, *)
public struct FavoritesView: View {
    public typealias ViewModel = AnyViewModel<FavoritesViewModel.Input, FavoritesViewModel.State>
    @ObservedObject private var viewModel: ViewModel
    @State private var showHidden = false
    @State private var showError = false
    @State private var alert = AlertView()
    @Environment(\.viewFactory) private var viewFactory: ViewFactory

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {

            VStack {
                List(viewModel.favoriteNumbers) {
                    viewFactory.favoriteRow($0, viewModel: viewModel)
                }
                .modifier(TitleModifier(title: .favoriteTitle))
            }
            .overlay(
                EmptyView()
                    .show(showHidden)
            )
            .overlay(
                ErrorView(errortext: "" )
                    .show(showError)
            )
            
            .onAppear{ [weak viewModel] in
                viewModel?.trigger(.favoritesList)
            }
            .onReceive(viewModel.viewState, perform: viewState)
            .initializeAlert(alert)
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
        case .error(let msg):
            alert.showAlertView(
                message: msg,
                okCompletion: ("OK", {
                    debugPrint("Dismissed pressed")
                })
            )
        default: break
        }
    }
}

