//
//  FavoritesViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//


import Foundation
import NumbersEx
import Shared

@available(iOS 13.0, *)
public final class FavoritesViewModel: ViewModel {

    public var favoritesUseCase: FavoritesNumberUseCaseType?
    public var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?
    @Published public var state = State()

    public init(favoritesUseCase: FavoritesNumberUseCaseType?, deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?) {
        self.favoritesUseCase = favoritesUseCase
        self.deleteFavoritesUseCase = deleteFavoritesUseCase

    }
}

@available(iOS 13.0, *)
extension FavoritesViewModel {

    public func trigger(_ input: Input) {
        switch input {
        case .delete(let number):
            debugPrint("Deleting number: \(number.numberValue) from favorites")
            do {
                if let value = try deleteFavoritesUseCase?.execute(number) {
                    handle(total: value)
                }
            } catch {
                
                self.state.viewState.send(.error("Error deleting favorites"))
            }

        case .favoritesList :
            do {
                if let value = try favoritesUseCase?.execute() {
                    handle(total: value)
                } else {
                    self.state.viewState.send(.emptyFavorites)
                }

            } catch {
                if let error = error as? FavoritesError {
                    switch error {
                    case .badDecoding:
                        self.state.viewState.send(.error("Bad decoding issue"))
                    case .emptyValue:
                        self.state.viewState.send(.emptyFavorites)
                    }
                }
               
            }
        }
    }

    private func handle(total: [NumberRowViewEntity]?) {
        guard let total = total else {
            self.state.viewState.send(.emptyFavorites)
            return  }
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
@available(iOS 13.0, *)
public extension FavoritesViewModel {

    enum Input {
        case delete(NumberRowViewEntity)
        case favoritesList
    }

    struct State: ModifiableStateData {
        var favoriteNumbers = [NumberRowViewEntity]()
        public  var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case emptyFavorites
        case favorites
        case error(String)
    }
    
}
