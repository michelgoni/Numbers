//
//  NumbersView.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Combine
import NumbersUI
import NumbersEx
import SwiftUI
import Shared

private extension CGFloat {
    static let padding = 12.0
}

private extension String {
    static let favoriteTitle = "Fun with numbers"
}

public struct NumbersView: View {

    public typealias ViewModel = AnyViewModel<NumbersViewModel.Input, NumbersViewModel.State>
    @ObservedObject public var viewModel: ViewModel
    @Environment(\.viewFactory) private var viewFactory
    @State private var alert = AlertView()
    @State private var isHideLoader: Bool = true
    @State private var searchText = ""
    @State private var isShowingSheet = false

    private let operational = SearchOperational()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {

                VStack {
                    FilterNumbersView(
                        viewModel: AnyViewModel(
                            FilterNumbersViewModel(operational: operational,
                                                   categories: Category.categories
                            )
                        )
                    )

                    List(viewModel.numbers) {
                        viewFactory.numberRow($0)
                    }
                    .animation(.linear, value: 1.0)
                    .listStyle(.inset)
                    .refreshable { [weak viewModel] in
                        viewModel?.trigger(.numbersList)
                    }
                    Button("Choose a random number!") {
                        isShowingSheet.toggle()
                    }
                    .show(!viewModel.numbers.isEmpty)
                    .buttonStyle(PrimaryButton())
                    .padding([.bottom, .leading, .trailing], .padding)
                    .sheet(isPresented: $isShowingSheet) {
                        viewFactory.randomNumberView()
                            .presentationDetents([.fraction(0.6)])
                            .presentationDragIndicator(.hidden)
                    }

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
            .onReceive(operational.output, perform: operationalState)
            .onReceive(viewModel.viewState, perform: viewState)
            .initializeAlert(alert)
            .onAppearOnce{ [weak viewModel] in
                viewModel?.trigger(.numbersList)
            }
        }

        .searchable(text: $searchText)
        .onSubmit(of: .search, runSearch)

    }

    func runSearch() {
        viewModel.trigger(.searchNumber(searchText))
    }

}

private extension NumbersView {

    func operationalState (_ state: SearchOperational.Element) {
        switch state {
        case .validFilter(let filter):
            guard let filter = Filter(rawValue: filter) else {
                viewModel.viewState.send(.filterError)
                return
            }
            viewModel.trigger(.filter(filter))
        case .invalidFilter:
            debugPrint("Invalid filter")
        }
    }

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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumbersView()
//            .environmentObject(
//                AnyViewModel(
//                    NumbersViewModel(numbersUseCase: FetchNumbersUseCase(repository: NumberRepositoryImplm(localDS: FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard), remoteDS: FetchNumberRemoteDSImplm())), numberUseCase: FetchNumberUseCase(repository: NumberRepositoryImplm(localDS: FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard), remoteDS: FetchNumberRemoteDSImplm())))
//                )
//            )
//    }
//}



