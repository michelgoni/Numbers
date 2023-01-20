//
//  NumbersViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 24/12/22.
//

import Combine
import Foundation
import NumbersEx

final class NumbersViewModel: ViewModel {

    @Published var state = State()
    private var numbersUseCase: FetchNumbersUseCaseType
    private lazy var cancellables = Set<AnyCancellable>()

    init(numbersUseCase: FetchNumbersUseCaseType) {
        self.numbersUseCase = numbersUseCase

    }
}

extension NumbersViewModel {
    @MainActor func trigger(_ input: Input) {
        switch input {
        case .numbersList:
            state.viewState.send(.loading)
            Task {
                do {
                    let value = try await numbersUseCase.execute()
                    self.state.numbers = value
                    self.state.viewState.send(.none)
                } catch {
                    self.state.viewState.send(.error)
                }
            }
        }
    }
}

extension NumbersViewModel {

    enum Input {
        case numbersList

    }

    struct State: ModifiableStateData {
        var numbers = [NumberRowViewEntity]()
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case error
        case loading
    }
}


