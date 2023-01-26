//
//  NumberRowViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 23/3/23.
//

import Combine
import Foundation
import NumbersEx
import Shared


final class NumberRowViewModel: ViewModel {

    private var favoritesUseCase: FetchNumbersUseCaseType?
    private var saveFavoritesUseCase: SaveFavoriteNumberUseCaseType?
    private var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?
    @Published var state = State()

    private lazy var cancellables = Set<AnyCancellable>()

    init(favoritesUseCase: FetchNumbersUseCaseType?,
         saveFavoritesUseCase: SaveFavoriteNumberUseCaseType?,
         deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?) {
        self.favoritesUseCase = favoritesUseCase
        self.saveFavoritesUseCase = saveFavoritesUseCase
        self.deleteFavoritesUseCase = deleteFavoritesUseCase
    }
}

extension NumberRowViewModel {

    func trigger(_ input: Input) {
        switch input {
        case .delete(let number):

            debugPrint("Deleting number: \(number.numberValue) from favorites")
            do {
                let value = try  deleteFavoritesUseCase?.execute(number)
                self.handle(total: value!)
            } catch {
                self.state.viewState.send(.error)
            }

        case .favoritesList:

            Task {
                do {
                    let value = try await favoritesUseCase?.execute()
                    self.handle(total: value!)
                } catch {
                    self.state.viewState.send(.error)
                }
            }

        case .prime:
            debugPrint("TODO prime")
        case .save(let number):
            debugPrint("Saving number: \(number.numberValue) into favorites")
            do {
                try saveFavoritesUseCase?.execute(number)
            } catch {
                self.state.viewState.send(.error)
            }
        }
    }

    private func handle(total: [NumberRowViewEntity] ) {
        switch total.isEmpty {
        case true:
            self.state.favoriteNumbers = []
            self.state.viewState.send(.emptyFavorites)
        case false:
            self.state.viewState.send(.favorites)
            self.state.favoriteNumbers = total

        }
    }
}

extension NumberRowViewModel {

    enum Input {
        case delete(NumberRowViewEntity)
        case favoritesList
        case prime
        case save(NumberRowViewEntity)
    }

    struct State: ModifiableStateData {
        var favoriteNumbers = [NumberRowViewEntity]()
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case emptyFavorites
        case favorites
        case error
    }
}
