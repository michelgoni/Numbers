//
//  RandomNumberUseCaseTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 17/1/23.
//

import Combine
import XCTest

@testable import Numbers

final class RandomNumberUseCaseTest: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private var sut: FetchRandomNumberUseCaseImplm!
    private var repositoryMock: RandomRepositoryMock!

    override func setUp() {
        super.setUp()
        sut = FetchRandomNumberUseCaseImplm()
        repositoryMock = RandomRepositoryMock()
        sut.repository = repositoryMock
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testExecuteFailure() async throws {
        repositoryMock.throwError = true
        do {
          let _ =  try await sut.execute()
        } catch {
            XCTAssertTrue(error == NumbersError.badResponse)
        }
    }

    func testExecuteSuccess() async throws {
        repositoryMock.numberEntity = numberEntity()
        do {
          let value =  try await sut.execute()
            XCTAssertTrue(value.numberValue == "1")
        } catch {
           XCTFail("test should contain some value")
        }
    }

    func testExecuteIsOnlyOnceInvoked() async throws {
        repositoryMock.numberEntity = numberEntity()
        do {
          let _ =  try await sut.execute()
            XCTAssertTrue(repositoryMock.isExecuteCalled)
        } catch {
           XCTFail("test should contain some value")
        }
    }


    private func numberEntity() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for this test")
    }

}
private final class RandomRepositoryMock: RandomNumberRepositoryType {
    var numberEntity: NumberEntity?
    var throwError = false
    var executeCallsCount = 0
    var isExecuteCalled: Bool {
        return executeCallsCount > 0
    }

    func fetchRandomNumber() async throws -> Numbers.NumberEntity {
        if throwError {
            throw NumbersError.badResponse
        } else {
            executeCallsCount += 1
            return numberEntity!
        }

    }
}
