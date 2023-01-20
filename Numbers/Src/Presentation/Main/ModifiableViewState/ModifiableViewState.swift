//
//  ModifiableViewState.swift
//  Numbers
//
//  Created by Michel Goñi on 30/12/22.
//

import Combine

public class ModifiableViewState<ViewState> {
    lazy var state = { PassthroughSubject<ViewState?, Never>() }()

    public init() {}
}

public protocol ModifiableStateData {
    associatedtype ViewState
    var modifiableView: ModifiableViewState<ViewState> { get }
}

public extension ModifiableStateData {
    var viewState: PassthroughSubject<ViewState?, Never> {
        get { modifiableView.state }
        set { modifiableView.state = newValue }
    }
}

