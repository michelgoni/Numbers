//
//  NumbersRepository.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//


import Foundation
import Combine
import SwiftUI

final class NumbersRepository: NumberRepositoryType {

    @AppStorage("") private var savedNumbers = Data()

    @Inject var localDS: UserDefaultsDataSourceType
    @Inject var remoteDS: RemoteDSType

    private lazy var cancellables = Set<AnyCancellable>()

    func delete(_ number: NumberEntity) -> ResponsePublisher<[NumberEntity]> {
        localDS.delete(number)
    }

    func fetchNumber(_ number: String) -> ResponsePublisher<[NumberEntity]> {

        return remoteDS.fetchNumbers([number])
            .map { arrayData in
                return arrayData.map {
                    let numberFact = String(decoding: $0, as: UTF8.self)
                    let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
                    return NumberEntity(
                        isFavorite: self.localDS.isFavorite(numberFact.split(separator: Character(" ")).first?.description ?? ""),
                        isPrime: self.isPrime(number: Int(number) ?? .zero),
                        numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
                        numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " ") )}
            }
            .eraseToAnyPublisher()
    }

    func fetchNumbersAsync() async throws -> [NumberEntity] {
        let numberArray = Array(Set((0..<20)
            .map{ _ in Int.random(in: 1 ... 99) }))
            .map {String($0)}

        return try await remoteDS.fetchNumbersAsync(numberArray).map({
            let numberFact = String(decoding: $0, as: UTF8.self)
            let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
            return NumberEntity(
                isFavorite: self.localDS.isFavorite(numberFact.split(separator: Character(" ")).first?.description ?? ""),
                isPrime: self.isPrime(number: Int(number) ?? .zero),
                numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
                numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "))
        })
    }
    
    func fetchNumbers() -> ResponsePublisher<[NumberEntity]> {
        let numberArray = Array(Set((0..<20)
            .map{ _ in Int.random(in: 1 ... 99) }))
            .map {String($0)}

        return remoteDS.fetchNumbers(numberArray.sorted())
            .map { arrayData in
                return arrayData.map {
                    let numberFact = String(decoding: $0, as: UTF8.self)
                    let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
                    return NumberEntity(
                        isFavorite: self.localDS.isFavorite(numberFact.split(separator: Character(" ")).first?.description ?? ""),
                        isPrime: self.isPrime(number: Int(number) ?? .zero),
                        numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
                        numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " ")
                    )
                }
            }
            .eraseToAnyPublisher()
    }

    func fetchSavedNumbers() -> ResponsePublisher<[NumberEntity]> {
        localDS.fetchSavedNumbers()
    }

    func isFavorite(_ number: String) -> Bool {
        localDS.isFavorite(number)
    }

    func saveNumber(_ number: NumberEntity) throws {
        do {
            try localDS.saveNumber(number)

        } catch {
            throw error
        }
    }

    // MARK: - Private
    private func isPrime(number: Int) -> Bool {
        guard number >= 2 else { return false }
        for i in 2 ..< number {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}
