//
//  DeleteNumberUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Shared
import XCTest
@testable import FeatureNumbersView


final class DeleteNumberUseCaseTest: XCTestCase {

    var sut: DeleteFavoriteNumberUseCaseType!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = DeleteFavoriteNumberUseCase(repository: repositoryMock)

    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testExecuteFailure() throws {
        repositoryMock.throwError = true
        repositoryMock.failure = .wrongStatusCode
        do {
            let _ = try  sut.execute(numberEntity())
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(error == NumberViewError.wrongStatusCode)
        }
    }

    func testExecuteSuccess() async throws {
        repositoryMock.returnValue.append(numberEntity())
        do {
            let value = try sut.execute(numberEntity())
            XCTAssertTrue(value.first?.numberValue == "1")
        } catch {
            XCTFail("Test should success")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws  {
        repositoryMock.returnValue.append(numberEntity())
        let _ = try! sut.execute(numberEntity())
        XCTAssertTrue(repositoryMock.callCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: "1",
            numberFact: "1 is the value for this test",
            isPrime: true)
    }

}
