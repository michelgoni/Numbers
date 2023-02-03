//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Combine
import Foundation
import NumbersEx

//sourcery: AutoMockable
 protocol IsPrimeUseCaseType {

    func execute(_ number: Int) async throws -> Bool
}

//sourcery: AutoMockable
final class IsPrimeUseCase: IsPrimeUseCaseType, UnwrappedUseCase {

    private var repository: PrimeNumberRepositoryType?

     init(repository: PrimeNumberRepositoryType) {
        self.repository = repository
    }

     func execute(_ number: Int) async throws -> Bool {
         try await execute(repository?.isPrime(number))
    }
}
