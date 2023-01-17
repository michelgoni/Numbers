//
//  NumberEntitity.swift
//  Numbers
//
//  Created by Michel Goñi on 27/12/22.
//

import Foundation

struct NumberEntity: Identifiable, Codable, Equatable {
    var id = UUID()
    var isFavorite: Bool
    var isPrime: Bool
    let numberValue: String
    let numberFact: String
}
