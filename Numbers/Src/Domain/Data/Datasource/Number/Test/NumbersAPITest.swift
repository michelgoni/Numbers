//
//  NumbersAPITest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 10/1/23.
//

import XCTest
import Combine
@testable import Numbers

class NumbersAPITest: XCTestCase, AwaitPublisher {

    var sut: RemoteDSType!
    let apiURL: URL = "http://numbersapi.com/1/trivia"
    private lazy var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = RemoteDSImpl(urlSession: urlSession)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testResponseFromNumberApiSuccess() throws {

        let data = try? JSONEncoder().encode([1])
        let unwrappedData = try XCTUnwrap(data)
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw NumbersError.badResponse
            }
            let response = HTTPURLResponse(url: self.apiURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, unwrappedData)
        }

        let value = try awaitSuccess(sut.fetchNumbers(["1"]), timeout: 1.0)

        XCTAssertTrue(!value.isEmpty)
    }

    func testResponseFromNumberApiFails() throws {

        MockURLProtocol.requestHandler = { request in
            throw NumbersError.badResponse
        }

        let value = try awaitFailure(sut.fetchNumbers(["1"]), timeout: 1.0)

        switch value {
        case .badRequest:
            break
        default:
            XCTFail("Received: \(String(describing: value)) instead")
        }
    }
}

private class MockURLProtocol: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {

        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {

        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {

            let (response, data) = try handler(request)


            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {

                client?.urlProtocol(self, didLoad: data)
            }


            client?.urlProtocolDidFinishLoading(self)
        } catch {

            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {

    }
}

