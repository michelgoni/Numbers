//
//  FavoritesUseCaseTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import Combine
import XCTest
@testable import Numbers

final class FavoritesUseCaseTest: XCTestCase, AwaitPublisher {

    private var cancellables = Set<AnyCancellable>()
    var sut: FavoritesNumberUseCase!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = FavoritesNumberUseCase()
        sut.repository = repositoryMock
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func testExecuteFailure() {
        repositoryMock.returnValue = .fail(.badResponse)
        let value = try? awaitFailure(sut.execute())

        switch value {
        case .badResponse:
            break
        default:
            XCTFail("Invalid error")
        }
    }

    func testExecuteSuccess() throws {
        let expected = [numberEntity()]
        repositoryMock.returnValue = .just(expected)
        let value = try? awaitSuccess(sut.execute())
        let finalValue = try XCTUnwrap(value?.first?.numberValue)
        XCTAssertEqual(finalValue, expected.first?.numberValue)

    }

    private func numberEntity() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for this test")
    }
}
