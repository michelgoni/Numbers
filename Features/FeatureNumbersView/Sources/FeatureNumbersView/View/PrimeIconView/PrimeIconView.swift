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
    @State private var isLoading = true
    @State private var showError = false

    let number: Int

    init(number: Int, viewModel: ViewModel) {
        self.number = number
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ZStack {
                viewModel.isPrime.primeImage
                    .show(!isLoading && !showError)
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .light))
                ProgressView()
                    .tint(.white)
                    .show(isLoading && !showError)
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                    .show(showError)
            }
            Text(verbatim: "Check your Wolfram APIKey to see if \(number) is prime")
                .foregroundColor(.red)
                .font(.callout)
                .show(showError)
        }


        .onReceive(viewModel.viewState, perform: viewState)
        .onAppear { [weak viewModel] in
            viewModel?.trigger(.checkNumber(number))
        }
        .enableInjection()

    }

    func viewState(_ state: PrimeIconViewModel.ViewState?) {
        switch state {
        case .loaded:
            self.isLoading = false
        case .loading:
            self.isLoading = true
        case .error:

            self.showError = true
        default: break
        }
    }
}
