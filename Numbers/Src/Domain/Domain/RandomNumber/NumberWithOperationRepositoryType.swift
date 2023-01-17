//
//  NumberWithOperationRepositoryType.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation

protocol NumberWithOperationRepositoryType {
    func fetchNumber(_ number: String)  async throws -> NumberEntity
}
