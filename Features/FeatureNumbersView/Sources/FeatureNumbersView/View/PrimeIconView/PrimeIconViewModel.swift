//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Foundation
import NumbersEx

final class PrimeIconViewModel: ViewModel {

    @Published var state = State()
    public var isPrimeUseCase: IsPrimeUseCaseType?

    init(isPrimeUseCase: IsPrimeUseCaseType?) {
        self.isPrimeUseCase = isPrimeUseCase
    }

}

extension PrimeIconViewModel {

    enum Input {
        case checkNumber(Int)
    }

    struct State: ModifiableStateData {
        var isPrime: Bool = false
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case error
        case loaded
        case loading
    }

}
@MainActor
extension PrimeIconViewModel {

    func trigger(_ input: Input) {
        self.state.viewState.send(.loading)
        switch input {
        case .checkNumber(let number):
            Task {

                do {
                    guard let useCase = isPrimeUseCase else { return }
                    self.state.isPrime = try await useCase.execute(number)
                    self.state.viewState.send(.loaded)
                } catch {
                    self.state.viewState.send(.error)
                }

            }
        }
    }
}
