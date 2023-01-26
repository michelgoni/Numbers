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

    func testExecuteFailure() async throws {
        repositoryMock.throwError = true
        repositoryMock.failure = .wrongStatusCode
        do {
            let _ = try await sut.execute("")
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(error == NumberViewError.wrongStatusCode)
        }
    }

    func testExecuteSuccess() async throws {
        repositoryMock.returnValue.append(numberEntity())
        do {
            let value = try await sut.execute("")
            XCTAssertTrue(value.numberValue == "1")
        } catch {
            XCTFail("Test should success")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws  {
        repositoryMock.returnValue.append(numberEntity())
        let _ = try! await sut.execute("")
        XCTAssertTrue(repositoryMock.callCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: "1",
            numberFact: "1 is the value for this test",
            isPrime: true)
    }

}
