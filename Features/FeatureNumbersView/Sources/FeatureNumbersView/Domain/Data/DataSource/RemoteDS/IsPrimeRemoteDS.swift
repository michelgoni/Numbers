//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Combine
import Foundation
import NumbersEx


protocol IsPrimeRemoteDSType {
    var urlSession: URLSession { get }
    func isNumberPrime(_ number: Int) async throws -> WolframAlphaResult?
}

final class IsPrimeRemoteDSImplm: IsPrimeRemoteDSType {

    var urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func isNumberPrime(_ number: Int) async throws -> WolframAlphaResult? {

        try await wolframAlpha(query: "\(number)")

    }

    func wolframAlpha(query: String) async throws -> WolframAlphaResult? {

        var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
        components.queryItems = [
            URLQueryItem(name: "input", value: query),
            URLQueryItem(name: "format", value: "plaintext"),
            URLQueryItem(name: "output", value: "JSON"),
            URLQueryItem(name: "appid", value: "INSERT_YOUR_WOLHFRAMALPHAAPIKEY"),
        ]

        let (data, _) =  try await URLSession.shared.data(from: components.url!)
        let value = try! JSONDecoder.init().decode(WolframAlphaResult.self, from: data)

        return value

    }

}
