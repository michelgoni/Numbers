//
//  RandomNumberRepositoryImplm.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation
import NumbersEx
import Shared

final class RandomNumberRepositoryImplm: RandomNumberRepositoryType {

     var remoteDS: RemoteDSRandomNumberType?
     var localDS: FetchNumberLocalDSType?

    init(remoteDS: RemoteDSRandomNumberType? , localDS: FetchNumberLocalDSType?) {
        self.remoteDS = remoteDS
        self.localDS = localDS
    }

    func fetchRandomNumber() async throws -> NumberRowViewEntity {

        let data = try await remoteDS?.fetchNumbersAsync(Int.random(in: 1 ... 99))

        let numberFact = String(decoding: data!, as: UTF8.self)
        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
        return NumberRowViewEntity(
            numberValue: Int(number) ?? .zero,
            numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "),
            isPrime: Int(number)?.isPrime ?? false)
    }

}

final class NumberWithOperationRepositoryImplm: NumberWithOperationRepositoryType {

    var remoteDS: RemoteDSRandomNumberType?
    var localDS: FetchNumberLocalDSType?

    init(remoteDS: RemoteDSRandomNumberType? , localDS: FetchNumberLocalDSType?) {
        self.remoteDS = remoteDS
        self.localDS = localDS
    }

    func fetchNumber(_ number: Int) async throws -> NumberRowViewEntity {

        let data = try await remoteDS?.fetchNumbersAsync(number)

        let numberFact = String(decoding: data!, as: UTF8.self)
        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
        return NumberRowViewEntity(
            numberValue: Int(number) ?? .zero,
            numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "),
            isPrime: Int(number)?.isPrime ?? false)
    }

}

