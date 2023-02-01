//
//  NumbersViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 24/12/22.
//

import Combine
import Foundation
import NumbersEx
import Shared

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

public extension NumbersViewModel {
    @MainActor func trigger(_ input: Input) {
        switch input {

        case .filter(let filter):
            switch filter {
            case .prime:
                self.state.numbers = self.state.numbers.filter {$0.numberValue.isPrime}
            case .odd: break
            case .even: break
            case .unknown:
                break
            }
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

public extension NumbersViewModel {

    enum Input {
        case filter(Filter)
        case numbersList
        case searchNumber(String)

    }

    struct State: ModifiableStateData {
        var numbers = [NumberRowViewEntity]()
        var categories = Category.categories
        public var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case filterError
        case error
        case loading
    }
}


