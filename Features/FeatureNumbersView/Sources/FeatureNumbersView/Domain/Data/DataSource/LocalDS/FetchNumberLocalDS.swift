//
//  FetchNumberLocalDS.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import SwiftUI
import Shared

//sourcery: AutoMockable
protocol FetchNumberLocalDSType {
    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]
    func fetchSavedNumbers() throws -> [NumberRowViewEntity]
    func isFavorite(_ number: Int) -> Bool
    func saveNumber(_ number: NumberRowViewEntity)  throws
}

//sourcery: AutoMockable
final class FetchNumberLocalDSImplm: FetchNumberLocalDSType {

    private let userDefaults: UserDefaults
    private var numbers = [NumberRowViewEntity]()
    @AppStorage("data") private var savedNumbers = Data([])

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        numbers.removeAll { $0.numberValue == number.numberValue }
        do {
            savedNumbers = try encode(numbers)
        } catch {
            throw NumberViewError.decodingLocalNumberError
        }
        if numbers.isEmpty {
            return []
        } else {
            guard let numbers = try? JSONDecoder().decode([NumberRowViewEntity].self,
                                                          from: self.savedNumbers) else {
                throw NumberViewError.decodingLocalNumberError }
            return numbers
        }
    }

    func fetchSavedNumbers() throws -> [NumberRowViewEntity] {
        guard let numbers = try? JSONDecoder()
            .decode([NumberRowViewEntity].self,
                    from: self.savedNumbers),
              !numbers.isEmpty else {
            throw NumberViewError.decodingLocalNumberError
        }
        self.numbers = numbers
        return numbers
    }

    func isFavorite(_ number: Int) -> Bool {
        guard let numbers = try? JSONDecoder()
            .decode([NumberRowViewEntity].self, from: self.savedNumbers),
              !numbers.isEmpty else {
            return false
        }
        return numbers.contains { $0.numberValue == number }
    }

    func saveNumber(_ number: NumberRowViewEntity) throws {
        if !numbers.contains(where: { $0.numberValue == number.numberValue }) {
            numbers.append(number)
            savedNumbers = try encode(numbers)
        }
    }

    private func encode(_ numbers: [NumberRowViewEntity]) throws  -> Data {
        guard let numbers = try? JSONEncoder()
            .encode(numbers) else { throw NumberViewError.decodingLocalNumberError }
        return numbers
    }
}
