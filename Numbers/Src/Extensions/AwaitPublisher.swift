//  AwaitPublisher.swift
//  Numbers
//
//  Created by Michel Goñi on 4/1/23.
//

import Foundation
import Combine
import Foundation
import XCTest

public protocol AwaitPublisher {}

public extension AwaitPublisher where Self: XCTestCase {

    func awaitSuccess<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 1.0,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {

        guard case .success(let output) = try awaitPublisher(
            publisher,
            timeout: timeout,
            file: file,
            line: line
        ) else {
            throw NSError(domain: "Invalid expect", code: -1)
        }

        return output
    }

    func awaitFailure<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 1.0,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Failure? {

        guard case .failure(let error) = try awaitPublisher(
            publisher,
            timeout: timeout,
            file: file,
            line: line
        ) else {
            throw NSError(domain: "Invalid expect", code: -1)
        }

        return error
    }

    private func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 1.0,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> Result<T.Output, T.Failure>? {

        var result: Result<T.Output, T.Failure>?
        let expectation = expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)

                case .finished:
                    break
                }

                expectation.fulfill()
            },

            receiveValue: { value in
                result = .success(value)
            }
        )

        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return unwrappedResult
    }

}


