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
    private var numberUseCase: FetchNumberUseCaseType
    private lazy var cancellables = Set<AnyCancellable>()

    init(numbersUseCase: FetchNumbersUseCaseType, numberUseCase: FetchNumberUseCaseType) {
        self.numbersUseCase = numbersUseCase
        self.numberUseCase = numberUseCase

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
        case .searchNumber(let number):
            state.viewState.send(.loading)
            Task {
                do {
                    self.state.numbers = []
                    self.state.numbers.append(try await numberUseCase.execute(number))
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
        case searchNumber(String)

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


