//
//  FetchNumberLocalDS.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
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
                    from: self.savedNumbers),
              !numbers.isEmpty else {
            throw NumberViewError.decodingLocalNumberError
        }
        self.numbers = numbers
        return numbers
    }
}
