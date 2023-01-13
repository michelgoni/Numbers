//
//  FetchNumbersUseCaseTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import Combine
import XCTest

@testable import Numbers


final class FetchNumbersUseCaseTest: XCTestCase, AwaitPublisher {
    private var cancellables = Set<AnyCancellable>()
    var sut: FetchNumbersUseCase!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = FetchNumbersUseCase()
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
        let finalExpected = try XCTUnwrap(expected).first?.numberValue
        XCTAssertEqual(finalExpected, finalValue)

    }

    func testExecuteIsOnlyOnceInvoked() {
        let expected = [numberEntity()]
        repositoryMock.returnValue = .just(expected)
        let _ = try? awaitSuccess(sut.execute())
        XCTAssertTrue(repositoryMock.isExecuteCalled)

    }

    private func numberEntity() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for this test")
    }

}
