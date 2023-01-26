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
    var respositoryMock = RepositoryMock()

    override func setUp() {
        super.setUp()
        sut = FavoritesNumberUseCase(repository: respositoryMock)
    }

    func testExecuteFails() throws {
        respositoryMock.failure = .badDecoding
        respositoryMock.throwError = true
        do {
            let _ = try sut.execute()
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testExecuteSuccess() throws {
        respositoryMock.returnValue.append(numberEntity())

        do {
            let value = try sut.execute()
            XCTAssertTrue(value?.first?.numberValue == "1")
        } catch {
            XCTFail("Test should success")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws  {
        respositoryMock.returnValue.append(numberEntity())
        let _ = try! sut.execute()
        XCTAssertTrue(respositoryMock.callCount == 1)
    }

    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: "1",
            numberFact: "1 is the value for this test",
            isPrime: true)
    }

}

class RepositoryMock: FavoriteNumbersRepositoryType {
    var returnValue = [NumberRowViewEntity]()
    var failure: FavoritesError!
    var throwError = false
    var callCount = 0

    func delete(_ number: Shared.NumberRowViewEntity) throws -> [NumberRowViewEntity]? {
        callCount += 1
        if throwError {
            throw failure
        } else {
            return returnValue
        }

    }

    func fetchFavoritesList() throws -> [NumberRowViewEntity]? {
        callCount += 1
        if throwError {
            throw failure
        } else {
            return returnValue
        }
    }


}

