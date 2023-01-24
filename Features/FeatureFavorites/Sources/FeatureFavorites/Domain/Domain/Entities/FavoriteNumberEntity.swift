//
//  FavoriteNumberEntity.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation

public struct FavoriteNumberEntity: Codable, Identifiable {
    public var id = UUID()
    let numberValue: String
    let numberFact: String
}

