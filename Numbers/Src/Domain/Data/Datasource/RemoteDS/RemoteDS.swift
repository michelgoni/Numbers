//
//  RemoteDS.swift
//  Numbers
//
//  Created by Michel Goñi on 22/12/22.
//

import Combine
import Foundation

private extension Int {
    static let okCode = 200 
}

typealias ResponsePublisher<T> = AnyPublisher<T, NumbersError>

protocol RemoteDSType {
    var urlSession: URLSession { get }
    func fetchNumbersAsync(_ numbers: [String]) async throws -> [Data]
    func fetchNumbers(_ numbers: [String])  -> ResponsePublisher<[Data]>
}

final class RemoteDSImpl: RemoteDSType {

    var urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchNumbersAsync(_ numbers: [String]) async throws -> [Data] {

        try await numbers.asyncMap {
            let (data, response) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\($0)/trivia")!)
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == .okCode
            else {
                throw NumbersError.badResponse
            }
            return data
        }
    }

    func fetchNumbers(_ numbers: [String]) -> ResponsePublisher<[Data]> {
        mergeNumbers(numbers: numbers)
            .reduce([]) { $0 + [$1] }
            .eraseToAnyPublisher()
    }

    // MARK: - Private
    private func fetchNumber(_ number: String)  -> ResponsePublisher<Data> {
        urlSession.dataTaskPublisher(for: URL(
            string: "http://numbersapi.com/\(number)/trivia")!)
        .tryMap(\.data)
        .mapError { error in (error as? NumbersError) ?? .badRequest(error.localizedDescription)}
        .eraseToAnyPublisher()
    }

    private func mergeNumbers(numbers: [String]) -> ResponsePublisher<Data> {
        numbers.dropFirst()
            .reduce(fetchNumber(numbers[0])) { partialResult, number in
                partialResult
                    .merge(with: fetchNumber(number))
                    .eraseToAnyPublisher()
            }
    }
}

private struct RemoteDSKey: InjectionKey {
    static var currentValue: RemoteDSType = RemoteDSImpl()
}


extension InjectedValues {
    var remoteDS: RemoteDSType {
        get { Self[RemoteDSKey.self] }
        set { Self[RemoteDSKey.self] = newValue }
    }
}
