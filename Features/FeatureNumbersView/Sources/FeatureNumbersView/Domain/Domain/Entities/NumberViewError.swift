//
//  NumberViewError.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation

enum NumberViewError: Error {
    case badResponse(String)
    case decodingLocalNumberError
    case wronDependency(String)
    case wrongStatusCode

}
