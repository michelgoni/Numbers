//
//  File.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import Foundation
import Shared
import SwiftUI

protocol FetchNumberLocalDSType {
    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]
    func fetchSavedNumbers() throws -> [NumberRowViewEntity]
    
}

final class FetchNumberLocalDSImplm: FetchNumberLocalDSType {

    private let userDefaults: UserDefaults
    private var numbers = [NumberRowViewEntity]()
    @AppStorage("") private  var savedNumbers = Data()

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
          numbers.removeAll { $0.numberValue == number.numberValue }
          do {
              savedNumbers = try encode(numbers)
          } catch {
              throw FavoritesError.badDecoding
          }
          if numbers.isEmpty {
              return []
          } else {
              guard let numbers = try? JSONDecoder().decode([NumberRowViewEntity].self, from: savedNumbers) else {
                  throw FavoritesError.badDecoding
              }
              return numbers
          }
      }

    func fetchSavedNumbers() throws -> [NumberRowViewEntity] {
        guard let numbers = try? JSONDecoder()
            .decode([NumberRowViewEntity].self,
                    from: self.savedNumbers) else {
            throw FavoritesError.badDecoding
        }
        self.numbers = numbers
        return numbers
    }

    private func encode(_ numbers: [NumberRowViewEntity]) throws  -> Data {
        guard let numbers = try? JSONEncoder()
            .encode(numbers) else { throw FavoritesError.badDecoding}
        return numbers
    }
}

