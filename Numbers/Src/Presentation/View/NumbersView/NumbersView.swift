//
//  NumbersView.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Combine
import SwiftUI

private extension CGFloat {
    static let padding = 12.0
}



private extension String {
    static let favoriteTitle = "Fun with numbers"
}

struct NumbersView: View {
    private typealias ViewModel = AnyViewModel<NumbersViewModel.Input, NumbersViewModel.State>
    @EnvironmentObject private var viewModel: ViewModel
    @State private var alert = AlertView()
    @State var isHideLoader: Bool = true
    @State private var searchText = ""
    @State private var isHalfSheet = true

    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                VStack {
                    List(viewModel.numbers) {
                        NumberRow(number: $0)
                            .environmentObject(
                                AnyViewModel(
                                    FavoritesViewModel()
                                )
                            )
                    }
                    .listStyle(.inset)

                    Button("See the number of the day!") {

                    }
                    .buttonStyle(PrimaryButton())
                    .padding([.bottom, .leading, .trailing], .padding)
                    .modifier(
                        TitleModifier(
                            title: .favoriteTitle)
                    )
                }
            }

            .overlay(
                LoaderView()
                .show(isHideLoader)
            )
            .onReceive(viewModel.viewState, perform: viewState)
            .initializeAlert(alert)
            .onAppearOnce{ [weak viewModel] in
                viewModel?.trigger(.numbersList)
            }
        }

        .searchable(text: $searchText)
        .onSubmit(of: .search, runSearch)
        .refreshable { [weak viewModel] in
            viewModel?.trigger(.numbersList)
        }
    }

    func runSearch() {
        viewModel.trigger(.singleNumber(searchText))
    }
}

private extension NumbersView {

    func viewState(_ state: NumbersViewModel.ViewState?) {
        isHideLoader = state == .loading
        switch state {
        case .error:
            alert.showAlertView(
                message: "Some error from the error",
                okCompletion: ("OK", {
                    debugPrint("Dismissed pressed")
                })
            )
            
        default: break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView()
            .environmentObject(
                AnyViewModel(
                    NumbersViewModel()
                )
            )
    }
}

