//
//  FavoriteiconViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//


import Combine
import Foundation
import NumbersEx
import Shared

public final class FavoriteIconViewModel: ViewModel {
    private var favoritesUseCase: IsfavoriteNumberUseCaseType?
    private var saveFavoritesUseCase: SaveFavoriteNumberUseCaseType?
    private var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?
    @Published public var state: State

    private lazy var cancellables = Set<AnyCancellable>()

    public init(isFavorite: Bool,
                favoritesUseCase: IsfavoriteNumberUseCaseType?,
                saveFavoritesUseCase: SaveFavoriteNumberUseCaseType?,
                deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?) {
        self.state = State(favoriteNumber: isFavorite)
        self.favoritesUseCase = favoritesUseCase
        self.saveFavoritesUseCase = saveFavoritesUseCase
        self.deleteFavoritesUseCase = deleteFavoritesUseCase
    }
}

public extension FavoriteIconViewModel {

    func trigger(_ input: Input) {
        switch input {
        case .delete(let number):
            debugPrint("Deleting number: \(number.numberValue) from favorites")
            do {
                let _ = try deleteFavoritesUseCase?.execute(number)

            } catch {
                self.state.viewState.send(.error)
            }
        case .isFavorite(let number):
            switch favoritesUseCase!.execute(number) {
            case true:
                self.state.favoriteNumber = true
                self.state.viewState.send(.favorite)
            case false:
                self.state.favoriteNumber = false
                self.state.viewState.send(.none)
            }

        case .modifyNumber where self.state.favoriteNumber == true:
            self.state.favoriteNumber.toggle()
            self.state.viewState.send(.none)
        case .modifyNumber where self.state.favoriteNumber == false:
            self.state.favoriteNumber.toggle()
            self.state.viewState.send(.favorite)
        case .save(let number):
            debugPrint("Saving number: \(number.numberValue) into favorites")
            do {
                try saveFavoritesUseCase?.execute(number)
            } catch {
                self.state.viewState.send(.error)
            }
        default: break
        }
    }

    
}

public extension FavoriteIconViewModel {

    enum Input {
        case delete(NumberRowViewEntity)
        case isFavorite(String)
        case modifyNumber
        case save(NumberRowViewEntity)
    }

    struct State: ModifiableStateData {
        var favoriteNumber: Bool
        public var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case favorite
        case error
    }
}

