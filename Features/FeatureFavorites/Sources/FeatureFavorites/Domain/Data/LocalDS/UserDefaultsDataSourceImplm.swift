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
    func fetchSavedNumbers() throws -> [NumberRowViewEntity]
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
                    from: self.savedNumbers) else {
            throw FavoritesError.badDecoding
        }
        self.numbers = numbers
        return numbers
    }
}

