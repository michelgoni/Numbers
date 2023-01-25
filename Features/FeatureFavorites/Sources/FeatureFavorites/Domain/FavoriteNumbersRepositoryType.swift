//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Shared

protocol FavoriteNumbersRepositoryType {
    func fetchFavoritesList() throws -> [NumberRowViewEntity]?
}

