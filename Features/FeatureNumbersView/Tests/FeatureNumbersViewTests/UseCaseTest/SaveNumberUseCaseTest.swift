//
//  SaveNumberUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Shared
import XCTest
@testable import FeatureNumbersView


final class SaveNumberUseCaseTest: XCTestCase {

    var sut: SaveFavoriteNumberUseCaseType!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = SaveFavoriteNumberUseCase(repository: repositoryMock)

    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testExecuteFailure()  throws {
        repositoryMock.throwError = true
        repositoryMock.failure = .wrongStatusCode
        do {
            try sut.execute(numberEntity())
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(error == NumberViewError.wrongStatusCode)
        }
    }

    func testExecuteSuccess() async throws {
        try sut.execute(numberEntity())
        XCTAssert(true)
    }

    func testExecuteIsOnlyOnceInvoked() async throws  {
       try sut.execute(numberEntity())
        XCTAssertTrue(repositoryMock.callCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: "1",
            numberFact: "1 is the value for this test",
            isPrime: true)
    }

}
