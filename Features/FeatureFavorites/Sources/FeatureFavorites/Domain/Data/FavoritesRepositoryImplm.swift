//
//  File.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import Foundation
import Shared

class FavoritesRepositoryImplm: FavoriteNumbersRepositoryType {

    private var localDS: FetchNumberLocalDSType?

    init(localDS: FetchNumberLocalDSType?) {
        self.localDS = localDS
    }

    func fetchFavoritesList() throws -> [NumberRowViewEntity]? {
        try localDS?.fetchSavedNumbers()
    }
}
