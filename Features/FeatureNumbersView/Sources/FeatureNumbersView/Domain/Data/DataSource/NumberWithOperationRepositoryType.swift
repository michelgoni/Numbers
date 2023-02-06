//
//  NumberWithOperationRepositoryType.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation
import Shared

public protocol NumberWithOperationRepositoryType {
    func fetchNumber(_ number: Int)  async throws -> NumberRowViewEntity
}
