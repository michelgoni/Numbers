//
//  AnyViewModel.swift
//  Numbers
//
//  Created by Michel Goñi on 24/12/22.
//

import Combine

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype Input
    associatedtype State

    var state: State { get }
    func trigger(_ input: Input)
}

@dynamicMemberLookup
final class AnyViewModel<Input, State>: ViewModel {
    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void

    public init<VM: ViewModel>(_ viewModel: VM) where VM.Input == Input, VM.State == State {
        wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        wrappedState = { viewModel.state }
        wrappedTrigger = viewModel.trigger
    }
}

extension AnyViewModel {

    var objectWillChange: AnyPublisher<Void, Never> { wrappedObjectWillChange() }

    var state: State { wrappedState() }

    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }

    subscript<Value>(dynamicMember keypath: KeyPath<State, Value>) -> Value {
        state[keyPath: keypath]
    }
}
