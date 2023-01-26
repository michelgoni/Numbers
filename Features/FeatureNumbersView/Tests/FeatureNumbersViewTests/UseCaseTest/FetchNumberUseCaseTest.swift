//
//  FetchNumberUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import Shared
import XCTest
@testable import FeatureNumbersView


final class FetchNumberUseCaseTest: XCTestCase {
    
    var sut: FetchNumberUseCaseType!
    private var repositoryMock = NumbersRepositoryMock()
    
    override func setUp() {
        super.setUp()
        sut = FetchNumberUseCase(repository: repositoryMock)
        
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

class NumbersRepositoryMock: NumberRepositoryType {
    var returnValue = [NumberRowViewEntity]()
    var failure: NumberViewError!
    var throwError = false
    var callCount = 0

    func fetchNumbers() async throws -> [NumberRowViewEntity] {
        callCount += 1
        if throwError {
            throw failure
        } else {
            return returnValue
        }
    }
    
    func fetchNumber(_ number: String) async throws -> NumberRowViewEntity {
        callCount += 1
        if throwError {
            throw failure
        } else {
            return returnValue.first!
        }

    }
    
    func isFavorite(_ number: String) -> Bool {
        true
    }
    
    func saveNumber(_ number: NumberRowViewEntity) throws {
        callCount += 1
        if throwError {
            throw failure
        } else {
            return Void()
        }
    }
}
