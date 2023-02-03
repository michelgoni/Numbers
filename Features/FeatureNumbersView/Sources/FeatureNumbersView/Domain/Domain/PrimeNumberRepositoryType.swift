//
//  PrimeNumberRepositoryType.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Foundation

protocol PrimeNumberRepositoryType {

    func isPrime(_ number: Int) async throws -> Bool
}
