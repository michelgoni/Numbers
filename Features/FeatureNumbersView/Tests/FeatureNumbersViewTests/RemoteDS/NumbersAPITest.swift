//
//  NumbersAPITest.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import XCTest
import Shared
@testable import FeatureNumbersView

final class NumbersAPITest: XCTestCase {

    var sut: FetchNumberRemoteDSType!
    let apiURL: URL = "http://numbersapi.com/1/trivia"

    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = FetchNumberRemoteDSImplm(urlSession: urlSession)
    }

    func testResponseFromNumberApiSuccess() async throws {

        let data = try? JSONEncoder().encode([1])
        let unwrappedData = try XCTUnwrap(data)
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {

                throw NumberViewError.badResponse("Bad response")
            }
            let response = HTTPURLResponse(url: self.apiURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, unwrappedData)
        }


        let value = try await sut.fetchNumbers(["1"])

        XCTAssertTrue(!value.isEmpty)
    }

    func testResponseFromNumberApiFails() async throws {
        MockURLProtocol.requestHandler = { request in

            throw NumberViewError.wrongStatusCode
        }
        do {
            let _ = try await sut.fetchNumbers(["1"])
        } catch {
            XCTAssertTrue(error == NumberViewError.wrongStatusCode)
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

public func == (lhs: Error, rhs: Error) -> Bool {
    guard type(of: lhs) == type(of: rhs) else { return false }
    let error1 = lhs as NSError
    let error2 = rhs as NSError
    return error1.domain == error2.domain && error1.code == error2.code && "\(lhs)" == "\(rhs)"
}

extension Equatable where Self : Error {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs as Error == rhs as Error
    }
}
