//
//  NumbersViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 24/12/22.
//

import Combine
import Foundation

final class NumbersViewModel: ViewModel {
    @Inject private var numbersUseCase: FetchNumbersUseCaseType
    @Inject private var numberUseCase: FetchNumberUseCaseType
    @Published var state = State()

    private lazy var cancellables = Set<AnyCancellable>()
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
//            numbersUseCase.execute()
//                .subscribe(on: DispatchQueue.global())
//                .receive(on: DispatchQueue.main)
//                .sink(receiveCompletion: { [weak self] completion in
//                    self?.state.viewState.send(.none)
//                    if case .failure = completion {
//                        self?.state.viewState.send(.error)
//                    }
//                }, receiveValue: { [weak self] value in
//                    self?.state.numbers = value
//                })
//                .store(in: &cancellables)

        case .singleNumber(let number):
            state.viewState.send(.loading)
            self.state.numbers = []

            numberUseCase.execute(number)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.state.viewState.send(.none)
                    if case .failure = completion {
                        self?.state.viewState.send(.error)
                    }
                }, receiveValue: { [weak self] value in
                    self?.state.numbers = value
                })
                .store(in: &cancellables)

        }
    }
}

extension NumbersViewModel {

    enum Input {
        case numbersList
        case singleNumber(String)
    }

    struct State: ModifiableStateData {
        var numbers = [NumberEntity]()
        var modifiableView = ModifiableViewState<ViewState>()
    }

    enum ViewState {
        case error
        case loading
    }
}


