////
////  FavoriteiconViewModel.swift
////  Numbers
////
////  Created by Michel Goñi on 10/1/23.
////
//
//
//import Combine
//import Foundation
//import NumbersEx
//
//final class FavoriteIconViewModel: ViewModel {
//    @Inject var favoritesUseCase: IsfavoriteNumberUseCaseType
//
//    @Published var state: State
//
//    private lazy var cancellables = Set<AnyCancellable>()
//
//    init(isFavorite: Bool) {
//        self.state = State(favoriteNumber: isFavorite)
//    }
//}
//
//extension FavoriteIconViewModel {
//
//    func trigger(_ input: Input) {
//        switch input {
//        case .isFavorite(let number):
//            switch favoritesUseCase.execute(number) {
//            case true:
//                self.state.favoriteNumber = true
//                self.state.viewState.send(.favorite)
//            case false:
//                self.state.favoriteNumber = false
//                self.state.viewState.send(.none)
//            }
//
//        case .modifyNumber where self.state.favoriteNumber == true:
//            self.state.favoriteNumber.toggle()
//            self.state.viewState.send(.none)
//        case .modifyNumber where self.state.favoriteNumber == false:
//            self.state.favoriteNumber.toggle()
//            self.state.viewState.send(.favorite)
//        default: break
//        }
//    }
//}
//
//extension FavoriteIconViewModel {
//
//    enum Input {
//        case isFavorite(String)
//        case modifyNumber
//    }
//
//    struct State: ModifiableStateData {
//        var favoriteNumber: Bool
//        var modifiableView = ModifiableViewState<ViewState>()
//    }
//
//    enum ViewState {
//        case favorite
//    }
//}
//
