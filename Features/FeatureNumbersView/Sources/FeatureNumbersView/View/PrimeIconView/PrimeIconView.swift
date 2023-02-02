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

    let number: Int

    init(number: Int, viewModel: ViewModel) {
        self.number = number
        self.viewModel = viewModel
    }

    var body: some View {

        viewModel.isPrime.primeImage
            .enableInjection()
    }
}
