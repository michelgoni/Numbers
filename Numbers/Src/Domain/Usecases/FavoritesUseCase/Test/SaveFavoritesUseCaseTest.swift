//
//  SaveFavoritesUseCaseTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import Combine
import XCTest
@testable import Numbers


final class SaveFavoritesUseCaseTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    var sut: SaveFavoriteNumberUseCase!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = SaveFavoriteNumberUseCase()
//        sut.repository = repositoryMock
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func testExecuteFailure() {
        repositoryMock.returnLocalValue = NumbersError.badResponse

        do {
            try sut.execute(numberEntity())
        } catch {
            XCTAssertTrue(error == NumbersError.badResponse)
        }
    }

    func testExecuteSuccess() {
        repositoryMock.throwError.toggle()

        do {
            try sut.execute(numberEntity())
        } catch {
            XCTFail("This test is not supposed to fail")
        }
    }

    func testExecuteIsOnlyOnceInvoked() {
        repositoryMock.returnLocalValue = NumbersError.badResponse

        do {
            try sut.execute(numberEntity())
        } catch {
            XCTAssertTrue(repositoryMock.isExecuteCalled)
        }

    }

    private func numberEntity() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                    numberValue: "1",
                     numberFact: "1 is the value for this test")
    }

}
