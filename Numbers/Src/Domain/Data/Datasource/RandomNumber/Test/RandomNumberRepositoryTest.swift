//
//  RandomNumberRepositoryTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 18/1/23.
//

import XCTest
import Combine
@testable import Numbers

final class RandomNumberRepositoryTest: XCTestCase {

    var sut: RandomNumberRepositoryImplm!
       lazy var cancellables = Set<AnyCancellable>()
       var localMock: UserDefaultsDataSourceTypeMock = UserDefaultsDataSourceTypeMock()
       var remoteMock: RemoteDSRandomNumberMock = RemoteDSRandomNumberMock()

       override func setUp() {
           super.setUp()
           sut = RandomNumberRepositoryImplm()
           sut.localDS = localMock
           sut.remoteDS = remoteMock
       }


       override func tearDown() {
           super.tearDown()
           sut = nil
       }

    func testFetchRandomNumberIsInvoked() async {
        remoteMock.returnValue = Data()
        let _ = try! await sut.fetchRandomNumber()
        XCTAssertTrue(remoteMock.isExecuteCalled)
    }

    func testFetchRandomNumberIsOnlyOnceInvoked() async {
        remoteMock.returnValue = Data()
        let _ = try! await sut.fetchRandomNumber()
        XCTAssertTrue(remoteMock.callCount == 1)
    }

    func testFetchRandomNumberMapsSuccess() async {
        remoteMock.returnValue = Data()
        let value = try! await sut.fetchRandomNumber()
        XCTAssertTrue(value.numberFact == "")
    }
}

final class RemoteDSRandomNumberMock: RemoteDSRandomNumberType {
    var urlSession: URLSession = URLSession.shared
    var callCount = 0
    var returnValue: Data!
    var isExecuteCalled: Bool {
        return callCount > 0
    }

    func fetchNumbersAsync(_ number: String) async throws -> Data {
        callCount += 1
        return returnValue
    }
}
