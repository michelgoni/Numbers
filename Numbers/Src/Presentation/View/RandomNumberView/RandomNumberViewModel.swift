//
//  RandomNumberViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Combine
import Foundation

final class RandomNumberViewModel: ViewModel {

    @Inject var randomNumberUsecase: FetchRandomNumberUseCaseType
    @Inject var plusNumberUsecase: FetchWithOperationNumberUseCaseType

    private lazy var cancellables = Set<AnyCancellable>()
    @Published var state = State()
}

extension RandomNumberViewModel {

    enum Input {
        case minus
        case randomNumber
        case plus
    }

    struct State: ModifiableStateData {
        var number: NumberEntity?
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case error
        case loading
    }
}

extension RandomNumberViewModel {
@MainActor
    func trigger(_ input: Input) {
        switch input {
        case .randomNumber:
            Task {
                self.state.number = try await randomNumberUsecase.execute()
            }
        case .plus:
            Task {
                guard let numberValue = self.state.number?.numberValue,
                      var intNumber = Int(numberValue),
                        intNumber > .zero else { return }
                intNumber += 1
                self.state.number = try await plusNumberUsecase.execute(String(intNumber))
            }
        case .minus:
            Task {
                guard let numberValue = self.state.number?.numberValue,
                        var intNumber = Int(numberValue),
                      intNumber > .zero else { return }
                intNumber -= 1
                self.state.number = try await plusNumberUsecase.execute(String(intNumber))
            }

        }
    }
}
