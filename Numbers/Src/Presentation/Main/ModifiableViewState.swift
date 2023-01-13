//
//  ModifiableViewState.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import Combine

class ModifiableViewState<ViewState> {
    lazy var state = { PassthroughSubject<ViewState?, Never>() }()

    public init() {}
}

protocol ModifiableStateData {
    associatedtype ViewState
    var modifiableView: ModifiableViewState<ViewState> { get }
}

extension ModifiableStateData {
    var viewState: PassthroughSubject<ViewState?, Never> {
        get { modifiableView.state }
        set { modifiableView.state = newValue }
    }
}

