//
//  RemoteDSRandomNumber.swift
//  Numbers
//
//  Created by Michel Goñi on 16/1/23.
//

import Foundation

private extension Int {
    static let okCode = 200
}

protocol RemoteDSRandomNumberType {
    var urlSession: URLSession { get }
    func fetchNumbersAsync(_ number: String) async throws -> Data
}

final class RemoteDSRandomNumber: RemoteDSRandomNumberType {

    var urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchNumbersAsync(_ number: String) async throws -> Data {
        let (data, response) = try await URLSession.shared
            .data(from: URL(string: "http://numbersapi.com/\(number)/trivia")!)
        guard
            let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == .okCode
        else {
            throw NumbersError.badResponse
        }
        return data
    }
}
