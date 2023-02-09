//
//  RandomNumberRepositoryType.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation
import Shared

public protocol RandomNumberRepositoryType {
    func fetchRandomNumber()  async throws -> NumberRowViewEntity
}
