//
//  NumbersRepositoryType.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import Shared


//sourcery: AutoMockable
public protocol NumberRepositoryType {
    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]
    func fetchNumbers()  async throws -> [NumberRowViewEntity]
    func fetchNumber(_ number: String)  async throws -> NumberRowViewEntity
    func isFavorite(_ number: String) -> Bool
    func saveNumber(_ number: NumberRowViewEntity) throws
}

