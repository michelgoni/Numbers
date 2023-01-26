//
//  FetchNumberRemoteDS.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import NumbersEx

private extension Int {
    static let okCode = 200
}

protocol FetchNumberRemoteDSType {
    var urlSession: URLSession { get }
    func fetchNumbers(_ numbers: [String]) async throws -> [Data]
    func fetchNumber(_ number: String) async throws -> Data
}

final class FetchNumberRemoteDSImplm: FetchNumberRemoteDSType {

    var urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchNumbers(_ numbers: [String]) async throws -> [Data] {
        try await numbers.asyncMap {
            do {
                let (data, response) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\($0)/trivia")!)
                guard
                    let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == .okCode
                else {
                    throw NumberViewError.wrongStatusCode
                }
                return data
            } catch {
                throw NumberViewError.badResponse(error.localizedDescription)
            }
        }
    }

    func fetchNumber(_ number: String) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)/trivia")!)
            guard
                let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == .okCode
            else {
                throw NumberViewError.wrongStatusCode
            }
            return data
        } catch {
            throw NumberViewError.badResponse(error.localizedDescription)
        }
    }

}
