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

    struct State {
        var isPrime = false
    }

}

extension PrimeIconViewModel {

    func trigger(_ input: Input) {
        switch input {
        case .checkNumber(let number):
            debugPrint("chcking")
        }
    }
}
