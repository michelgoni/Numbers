//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Shared

//sourcery: AutoMockable
class FavoritesRepositoryImplm: FavoriteNumbersRepositoryType {

    private var localDS: FetchNumberLocalDSType?

    init(localDS: FetchNumberLocalDSType?) {
        self.localDS = localDS
    }

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]? {
        try localDS?.delete(number)
    }

    func fetchFavoritesList() throws -> [NumberRowViewEntity]? {
        try localDS?.fetchSavedNumbers()
    }
}
