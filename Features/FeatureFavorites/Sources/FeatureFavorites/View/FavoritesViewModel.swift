//
//  FavoritesViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//


import Foundation
import NumbersEx

@available(iOS 13.0, *)
public final class FavoritesViewModel: ViewModel {

    public var favoritesUseCase: FavoritesNumberUseCaseType?
    public var deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?
    @Published public var state = State()

    public init(favoritesUseCase: FavoritesNumberUseCaseType? , deleteFavoritesUseCase: DeleteFavoriteNumberUseCaseType?) {
        self.favoritesUseCase = favoritesUseCase
        self.deleteFavoritesUseCase = deleteFavoritesUseCase

    }
}

@available(iOS 13.0, *)
extension FavoritesViewModel {

    public func trigger(_ input: Input) {
        switch input {
        case .delete(let number):
            Task {
                debugPrint("Deleting number: \(number.numberValue) from favorites")
                self.state.favoriteNumbers = try! await deleteFavoritesUseCase!.execute(number)
                handle(total: self.state.favoriteNumbers)
            }


        case .favoritesList :
            Task {
                self.state.favoriteNumbers = try! await favoritesUseCase!.execute()
                handle(total: self.state.favoriteNumbers)
            }
        }
    }

    private func handle(total: [FavoriteNumberEntity] ) {
        switch total.isEmpty {
        case true:

            self.state.viewState.send(.emptyFavorites)
        case false:
            self.state.viewState.send(.favorites)


        }
    }
}
@available(iOS 13.0, *)
public extension FavoritesViewModel {

    enum Input {
        case delete(FavoriteNumberEntity)
        case favoritesList

    }

    struct State: ModifiableStateData {
        var favoriteNumbers = [FavoriteNumberEntity]()
        public  var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case emptyFavorites
        case favorites
        case error
    }
}
