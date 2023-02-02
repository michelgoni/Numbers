//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Combine
import Foundation

//sourcery: AutoMockable
 protocol IsPrimeUseCaseType {

    func execute(_ number: Int) -> ResponsePublisher<Bool>
}

//sourcery: AutoMockable
 final class IsPrimeUseCase: IsPrimeUseCaseType {

    private var repository: PrimeNumberRepositoryType?

     init(repository: PrimeNumberRepositoryType) {
        self.repository = repository
    }

     func execute(_ number: Int) -> ResponsePublisher<Bool> {
         repository!.isPrime(number)
    }
}
