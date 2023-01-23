//
//  NumbersViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 24/12/22.
//

import Combine
import Foundation
import NumbersEx

final public class NumbersViewModel: ViewModel {

     @Published public var state = State()
    public var numbersUseCase: FetchNumbersUseCaseType?
    public var numberUseCase: FetchNumberUseCaseType?
    private lazy var cancellables = Set<AnyCancellable>()

    public init(numbersUseCase: FetchNumbersUseCaseType?, numberUseCase: FetchNumberUseCaseType?) {
        self.numbersUseCase = numbersUseCase
        self.numberUseCase = numberUseCase

    }
}

extension NumbersViewModel {
    @MainActor public func trigger(_ input: Input) {
        switch input {
        case .numbersList:
            state.viewState.send(.loading)
            Task {
                do {
                    guard let numbersUseCase = numbersUseCase else { return }
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
                    guard let numberUseCase = numberUseCase else { return }
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

    public enum Input {
        case numbersList
        case searchNumber(String)

    }

    public struct State: ModifiableStateData {
        var numbers = [NumberRowViewEntity]()
        public var modifiableView = ModifiableViewState<ViewState>()
    }

    public enum ViewState {
        case error
        case loading
    }
}


