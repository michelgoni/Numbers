////
////  RandomNumberRepositoryImplm.swift
////  Numbers
////
////  Created by Michel Goñi on 16/1/23.
////
//
//import Foundation
//import NumbersEx
//
//final class RandomNumberRepositoryImplm: RandomNumberRepositoryType {
//
//     var remoteDS: RemoteDSRandomNumberType!
//     var localDS: UserDefaultsDataSourceType!
//
//    func fetchRandomNumber() async throws -> NumberEntity {
//
//        let data = try await remoteDS.fetchNumbersAsync(String(Int.random(in: 1 ... 99)))
//
//        let numberFact = String(decoding: data, as: UTF8.self)
//        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
//        return NumberEntity(
//            isFavorite: self.localDS.isFavorite(numberFact.split(separator: Character(" ")).first?.description ?? ""),
//            isPrime: Int(number)?.isPrime ?? false,
//            numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
//            numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "))
//    }
//
//}
//
//final class NumberWithOperationRepositoryImplm: NumberWithOperationRepositoryType {
//
//     var remoteDS: RemoteDSRandomNumberType!
//     private var localDS: UserDefaultsDataSourceType!
//
//    func fetchNumber(_ number: String) async throws -> NumberEntity {
//
//        let data = try await remoteDS.fetchNumbersAsync(number)
//
//        let numberFact = String(decoding: data, as: UTF8.self)
//        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
//        return NumberEntity(
//            isFavorite: self.localDS.isFavorite(numberFact.split(separator: Character(" ")).first?.description ?? ""),
//            isPrime: Int(number)?.isPrime ?? false,
//            numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
//            numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "))
//    }
//
//}
//
