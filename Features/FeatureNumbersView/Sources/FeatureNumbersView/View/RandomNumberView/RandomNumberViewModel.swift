//
//  RandomNumberViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Combine
import Foundation
import NumbersEx
import Shared

final class RandomNumberViewModel: ViewModel {

    var randomNumberUsecase: FetchRandomNumberUseCaseType?
    var plusNumberUsecase: FetchWithOperationNumberUseCaseType?

    private lazy var cancellables = Set<AnyCancellable>()
    @Published var state = State()

    init(randomNumberUsecase: FetchRandomNumberUseCaseType?, plusNumberUsecase: FetchWithOperationNumberUseCaseType?) {
        self.randomNumberUsecase = randomNumberUsecase
        self.plusNumberUsecase = plusNumberUsecase
    }
}

extension RandomNumberViewModel {

    enum Input {
        case minus
        case randomNumber
        case plus
    }

    struct State: ModifiableStateData {
        var number: NumberRowViewEntity?
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case loaded
        case loading
    }
}

extension RandomNumberViewModel {
@MainActor
    func trigger(_ input: Input) {
        self.state.viewState.send(.loading)
        switch input {
        case .randomNumber:
            Task {
                self.state.number = try await randomNumberUsecase?.execute()
                self.state.viewState.send(.loaded)
            }
        case .plus:
            Task {
                guard let numberValue = self.state.number?.numberValue,
                      var intNumber = Int(numberValue),
                        intNumber > .zero else { return }
                intNumber += 1
                self.state.number = try await plusNumberUsecase?.execute(String(intNumber))
                self.state.viewState.send(.loaded)
            }
        case .minus:
            Task {
                guard let numberValue = self.state.number?.numberValue,
                        var intNumber = Int(numberValue),
                      intNumber > .zero else { return }
                intNumber -= 1
                self.state.number = try await plusNumberUsecase?.execute(String(intNumber))
                self.state.viewState.send(.loaded)
            }

        }
    }
}
