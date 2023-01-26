//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Shared

protocol FavoriteNumbersRepositoryType {
    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]?
    func fetchFavoritesList() throws -> [NumberRowViewEntity]?
}

