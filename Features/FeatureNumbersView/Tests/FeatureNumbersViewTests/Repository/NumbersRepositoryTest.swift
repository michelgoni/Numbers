//
//  NumbersReposositoryTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 3/1/23.
//

import XCTest
import Shared
@testable import FeatureNumbersView

final class NumbersRepositoryTest: XCTestCase {

    var localMock: FetchNumberLocalDSTypeMock = FetchNumberLocalDSTypeMock()
    var remoteMock: FetchNumberRemoteDSTypeMock = FetchNumberRemoteDSTypeMock()
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
        remoteMock.fetchNumbersReturnValue = [Data()]
        let _ = try! await sut.fetchNumbers()
        XCTAssertTrue(remoteMock.fetchNumbersCalled)
    }

    func testFetchLocalNumberIsOnlyOnceInvoked() async {
        remoteMock.fetchNumbersReturnValue = [Data()]
        let _ = try! await sut.fetchNumbers()
        XCTAssertTrue(remoteMock.fetchNumbersCallsCount == 1)
    }

    func testIsFavorite()  {
        localMock.isFavoriteReturnValue = true
        let value = sut.isFavorite(.zero)
        XCTAssertTrue(value)
    }

    func testSaveIsInvoked()  {
        localMock.fetchSavedNumbersReturnValue = []
        try! sut.saveNumber(NumberRowViewEntity(numberValue: 1,
                                                numberFact: ""))

        XCTAssertTrue(localMock.saveNumberCalled)
    }

    func testSaveIsOnlyOnceInvoked()  {
        localMock.fetchSavedNumbersReturnValue = []
        try! sut.saveNumber(NumberRowViewEntity(numberValue: 1, numberFact: ""))

        XCTAssertTrue(localMock.saveNumberCallsCount == 1)
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
        remoteMock.fetchNumbersReturnValue = [Data()]
        let value = try! await sut.fetchNumbers()
        XCTAssertTrue(!value.isEmpty)
    }
}
