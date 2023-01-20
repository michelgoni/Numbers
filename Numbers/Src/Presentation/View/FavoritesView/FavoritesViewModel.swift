//
//  FavoritesViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import Combine
import Foundation
import NumbersEx


final class FavoritesViewModel: ViewModel {
    @Inject var isFavoriteUseCase: IsfavoriteNumberUseCaseType
    @Inject var favoritesUseCase: FavoritesNumberUseCaseType
    @Inject var saveFavoritesUseCase: SaveFavoriteNumberUseCaseType
    @Inject var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType
    @Published var state = State()

    private lazy var cancellables = Set<AnyCancellable>()
}

extension FavoritesViewModel {

    func trigger(_ input: Input) {
        switch input {
        case .delete(let number):
            debugPrint("Deleting number: \(number.numberValue) from favorites")
            deleteFavoritesUseCase.execute(number)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.state.viewState.send(.error)
                    }
                }, receiveValue: { [weak self] value in
                    self?.handle(total: value)
                })
                .store(in: &cancellables)

        case .favoritesList :
            favoritesUseCase.execute()
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.state.viewState.send(.error)
                    }
                }, receiveValue: { [weak self] value in
                    self?.handle(total: value)
                })
                .store(in: &cancellables)

        case .prime:
            debugPrint("TODO prime")
        case .save(let number):
            debugPrint("Saving number: \(number.numberValue) as favorite")
            do {
                try saveFavoritesUseCase.execute(number)
            } catch {
                self.state.viewState.send(.error)
            }

        }
    }

    private func handle(total: [NumberEntity] ) {
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

extension FavoritesViewModel {

    enum Input {
        case delete(NumberEntity)
        case favoritesList
        case prime
        case save(NumberEntity)
    }

    struct State: ModifiableStateData {
        var favoriteNumbers = [NumberEntity]()
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case emptyFavorites
        case favorites
        case error
    }
}
