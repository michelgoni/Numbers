//
//  NumbersReposositoryTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 3/1/23.
//

import XCTest
import Shared
@testable import FeatureNumbersView

final class NumbersReposositoryTest: XCTestCase, AwaitPublisher {

    var localMock: UserDefaultsDataSourceTypeMock = UserDefaultsDataSourceTypeMock()
    var remoteMock: RemoteDataSourceTypeMock = RemoteDataSourceTypeMock()
    var sut: NumberRepositoryImplm!


    override func setUp() {
        super.setUp()
        sut = NumberRepositoryImplm(localDS: localMock, remoteDS: remoteMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }


    func testIsRemoteDSInvoked() async {
        remoteMock.data = Data()
        let _ = try! await sut.fetchNumbers()
        XCTAssertTrue(remoteMock.isExecuteCalled)
    }

    func testFetchLocalNumberIsOnlyOnceInvoked() async {
        remoteMock.data = Data()
        let _ = try! await sut.fetchNumbers()
        XCTAssertTrue(remoteMock.callCount == 1)
    }

    func testIsFavorite()  {
        remoteMock.data = Data()
        let value = sut.isFavorite("")
        XCTAssertTrue(value)
    }

    func testSaveIsInvoked()  {
        localMock.returnValue = []
        try! sut.saveNumber(NumberRowViewEntity(numberValue: "1", numberFact: "", isPrime: true))

        XCTAssertTrue(localMock.isInvoked)
    }

    func testSaveIsOnlyOnceInvoked()  {
        localMock.returnValue = []
        try! sut.saveNumber(NumberRowViewEntity(numberValue: "1", numberFact: "", isPrime: true))

        XCTAssertTrue(localMock.callCount == 1)
    }

    func testFetchRemoteNumberDoesNotMapProperly() {
        let json = """
                       {"aaa":""}
                       """
            .data(using: .utf8)!
        let sut = try? JSONDecoder().decode([NumberRowViewEntity].self, from: json)
        XCTAssertNil(sut)
    }

    func testFetchRemoteNumberMapsProperly() async {
        remoteMock.data = Data()
        let value = try! await sut.fetchNumbers()
        XCTAssertTrue(!value.isEmpty)
    }
}

// MARK: -Mock

class RemoteDataSourceTypeMock: FetchNumberRemoteDSType {


    var urlSession: URLSession = URLSession.shared
    var data: Data!
    var isInvoked = false
    var callCount = 0
    var isExecuteCalled: Bool {
        return callCount > 0
    }

    func fetchNumbers(_ numbers: [String]) async throws -> [Data] {
        isInvoked = true
        callCount += 1
        return [data]
    }

    func fetchNumber(_ number: String) async throws -> Data {
        Data()
    }

}

class UserDefaultsDataSourceTypeMock: FetchNumberLocalDSType {



    var isInvoked = false
    var callCount = 0
    var isExecuteCalled: Bool {
        return callCount > 0
    }
    var returnValue: [NumberRowViewEntity]!

    var isFavorite = false

    func fetchSavedNumbers() throws -> [NumberRowViewEntity] {
        isInvoked.toggle()
        callCount += 1
        return returnValue
    }

    func isFavorite(_ number: String) -> Bool {
        isFavorite.toggle()
        return isFavorite
    }

    func saveNumber(_ number: NumberRowViewEntity) throws {
        isInvoked.toggle()
        callCount += 1
    }
}

