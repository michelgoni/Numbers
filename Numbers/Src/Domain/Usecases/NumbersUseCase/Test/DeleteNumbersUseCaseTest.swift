//
//  DeleteNumbersUseCaseTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import XCTest
@testable import Numbers
import Combine

final class DeleteNumbersUseCaseTest: XCTestCase, AwaitPublisher {

    private var cancellables = Set<AnyCancellable>()
    var sut: DeleteFavoriteNumberUseCase!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = DeleteFavoriteNumberUseCase()
        sut.repository = repositoryMock
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
        sut = nil
    }

    func testExecuteFailure() {
        repositoryMock.returnValue = .fail(.badResponse)
        let value = try? awaitFailure(sut.execute(numberEntity()))

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
        let value = try? awaitSuccess(sut.execute(numberEntity()))
        let finalValue = try XCTUnwrap(value?.first?.numberValue)
        XCTAssertEqual(finalValue, expected.first?.numberValue)

    }

    func testExecuteIsOnlyOnceInvoked() {
        let expected = [numberEntity()]
        repositoryMock.returnValue = .just(expected)
        let _ = try? awaitSuccess(sut.execute(numberEntity()))
        XCTAssertTrue(repositoryMock.isExecuteCalled)

    }

    private func numberEntity() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for this test")
    }

}

// MARK: - Mock

class NumbersRepositoryMock: NumberRepositoryType {

    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!
    var returnLocalValue: NumbersError!
    var executeCallsCount = 0
    var throwError = true
    var isExecuteCalled: Bool {
        return executeCallsCount > 0
    }

    func fetchNumbers() -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        executeCallsCount += 1
         return returnValue.eraseToAnyPublisher()
    }

    func fetchNumbersAsync() async throws -> [Numbers.NumberEntity] {
        []
    }

    func fetchNumber(_ number: String) -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        executeCallsCount += 1
         return returnValue.eraseToAnyPublisher()
    }

    func fetchSavedNumbers() -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        returnValue.eraseToAnyPublisher()
    }

    func delete(_ number: Numbers.NumberEntity) -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        executeCallsCount += 1
        return returnValue.eraseToAnyPublisher()
    }

    func isFavorite(_ number: String) -> Bool {
        false
    }

    func saveNumber(_ number: Numbers.NumberEntity) throws {
        executeCallsCount += 1
        if throwError {
            throw returnLocalValue
        } else {
            return Void()
        }

    }
}
