//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Combine
import Foundation
import NumbersEx

final class PrimeNumberRepositoryImplm: PrimeNumberRepositoryType {

    private var remoteDS: IsPrimeRemoteDSType?
    private lazy var cancellables = Set<AnyCancellable>()
    private lazy var cache = Set<CacheEntity>()

    init(remoteDS: IsPrimeRemoteDSType?) {
        self.remoteDS = remoteDS
    }
    
    func isPrime(_ number: Int) async throws -> Bool {

        if cache.map({$0.number}).contains(number) {
            return cache.first { $0.number == number }?.isPrime ?? false
        } else {
            let value = try await remoteDS?.isNumberPrime(number)
            guard let value = value?.queryresult.pods.filter({$0.id == "PrimeFactorization"}).first?.subpods.first?.plaintext.contains("prime") else { return false }
            let entity = CacheEntity(number: number, isPrime: value)
            cache.insert(entity)
            return value
        }
    }
}
