//
//  DeleteNumberUsecaseTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Shared
import XCTest
@testable import FeatureFavorites

final class DeleteNumberUsecaseTest: XCTestCase {

    var sut: DeleteFavoriteNumberUseCaseType!
    var repositoryMock = FavoriteNumbersRepositoryTypeMock()

    override func setUp() {
        super.setUp()
        sut = DeleteFavoriteNumberUseCase(repository: repositoryMock)
    }

    func testExecuteFails() throws {
        repositoryMock.deleteThrowableError = FavoritesError.badDecoding

        do {
            _ = try sut.execute(numberEntity())
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testExecuteSuccess() throws {
        repositoryMock.deleteReturnValue = [numberEntity()]

        do {
            let value = try sut.execute(numberEntity())
            XCTAssertTrue(value.first!.numberValue == 1)
        } catch {
            XCTFail("Test should success")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws {
        repositoryMock.deleteReturnValue = [numberEntity()]
        _ = try! sut.execute(numberEntity())
        XCTAssertTrue(repositoryMock.deleteCallsCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: 1,
            numberFact: "1 is the value for this test")
    }

}
