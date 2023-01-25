//
//  NumbersRepositoryType.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import Shared

public protocol NumberRepositoryType {
    func fetchNumbers()  async throws -> [NumberRowViewEntity]
    func fetchNumber(_ number: String)  async throws -> NumberRowViewEntity
    func saveNumber(_ number: NumberRowViewEntity) throws
}

