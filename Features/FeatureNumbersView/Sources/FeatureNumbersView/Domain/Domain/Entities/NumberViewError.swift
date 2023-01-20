//
//  NumberViewError.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation

enum NumberViewError: Error {
    case decodingLocalNumberError
    case wrongStatusCode
    case badResponse(String)
}
