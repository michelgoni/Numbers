//
//  FetchNumberLocalDS.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import SwiftUI
import Shared

protocol FetchNumberLocalDSType {
    func fetchSavedNumbers() throws -> [NumberRowViewEntity]
    func isFavorite(_ number: String) -> Bool
    func saveNumber(_ number: NumberRowViewEntity)  throws


}

final class FetchNumberLocalDSImplm: FetchNumberLocalDSType {

    private let userDefaults: UserDefaults
    private var numbers = [NumberRowViewEntity]()
    @AppStorage("") private  var savedNumbers = Data()

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
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

    func isFavorite(_ number: String) -> Bool {
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
