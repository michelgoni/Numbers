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

public final class RandomNumberViewModel: ViewModel {

    var randomNumberUsecase: FetchRandomNumberUseCaseType?
    var plusNumberUsecase: FetchWithOperationNumberUseCaseType?

    private lazy var cancellables = Set<AnyCancellable>()
    @Published public var state = State()

   public init(randomNumberUsecase: FetchRandomNumberUseCaseType?, plusNumberUsecase: FetchWithOperationNumberUseCaseType?) {
        self.randomNumberUsecase = randomNumberUsecase
        self.plusNumberUsecase = plusNumberUsecase
    }
}

public extension RandomNumberViewModel {

    enum Input {
        case minus
        case randomNumber
        case plus
    }

    struct State: ModifiableStateData {
        var number: NumberRowViewEntity?
        var numbers = [NumberRowViewEntity]()
        public var modifiableView = ModifiableViewState<ViewState>()

        var lastPage: Int {
            numbers.count - 1
        }
    }

    enum ViewState {
        case loaded
        case loading
    }
}

public extension RandomNumberViewModel {
@MainActor
    func trigger(_ input: Input) {
        self.state.viewState.send(.loading)
        switch input {
        case .randomNumber:
            Task {
                guard let number = try await randomNumberUsecase?.execute() else { return }
                self.state.numbers.append(number)
                self.state.viewState.send(.loaded)
            }
        case .plus:
            Task {
                guard var numberValue = self.state.number?.numberValue,
                        numberValue > .zero else { return }
                numberValue -= 1
                self.state.number = try await plusNumberUsecase?.execute(numberValue)
                self.state.viewState.send(.loaded)
            }
        case .minus:
            Task {
                guard var numberValue = self.state.number?.numberValue,
                        numberValue > .zero else { return }
                numberValue -= 1
                self.state.number = try await plusNumberUsecase?.execute(numberValue)
                self.state.viewState.send(.loaded)
            }

        }
    }
}
