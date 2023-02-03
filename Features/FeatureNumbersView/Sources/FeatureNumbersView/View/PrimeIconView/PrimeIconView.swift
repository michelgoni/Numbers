//
//  PrimeIconView.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Inject
import NumbersEx
import SwiftUI

struct PrimeIconView: View {

    public typealias ViewModel = AnyViewModel<PrimeIconViewModel.Input, PrimeIconViewModel.State>
    @ObservedObject private var iO = Inject.observer
    @ObservedObject public var viewModel: ViewModel
    @State private var isLoading: Bool = true

    let number: Int

    init(number: Int, viewModel: ViewModel) {
        self.number = number
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            viewModel.isPrime.primeImage
                .show(!isLoading)
            ProgressView()
                .show(isLoading)

        }
        .enableInjection()
        .onReceive(viewModel.viewState, perform: viewState)
        .onAppear { [weak viewModel] in
            viewModel?.trigger(.checkNumber(number))
        }

    }

    func viewState(_ state: PrimeIconViewModel.ViewState?) {
        switch state {
        case .loaded:
            self.isLoading = false
        case .loading:
            self.isLoading = true
        default: break
        }
    }
}
