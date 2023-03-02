//
//  FavoritesNumbersUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Shared
import XCTest
@testable import FeatureFavorites

final class FavoritesNumbersUseCaseTest: XCTestCase {

    var sut: FavoritesNumberUseCaseType!
    var repositoryMock = FavoriteNumbersRepositoryTypeMock()

    override func setUp() {
        super.setUp()
        sut = FavoritesNumberUseCase(repository: repositoryMock)
    }

    func testExecuteFails() throws {

        repositoryMock.fetchFavoritesListThrowableError = FavoritesError.badDecoding
        do {
            let _ = try sut.execute()
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testExecuteSuccess() throws {
        repositoryMock.fetchFavoritesListReturnValue = [numberEntity()]

        do {
            let value = try sut.execute()
            XCTAssertTrue(value?.first?.numberValue == 1)
        } catch {
            XCTFail("Test should success")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws  {
        repositoryMock.fetchFavoritesListReturnValue = [numberEntity()]
        let _ = try! sut.execute()
        XCTAssertTrue(repositoryMock.fetchFavoritesListCallsCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: 1,
            numberFact: "1 is the value for this test")
    }
}
