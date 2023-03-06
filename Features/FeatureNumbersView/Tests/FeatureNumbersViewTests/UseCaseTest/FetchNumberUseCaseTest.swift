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
    private var repositoryMock = NumberRepositoryTypeMock()
    
    override func setUp() {
        super.setUp()
        sut = FetchNumberUseCase(repository: repositoryMock)
        
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testExecuteFailure() async throws {

        repositoryMock.fetchNumberThrowableError = NumberViewError.wrongStatusCode
        do {
            let _ = try await sut.execute("")
            XCTFail("Test should fail")
        } catch {
            XCTAssertTrue(error == NumberViewError.wrongStatusCode)
        }
    }
    
    func testExecuteSuccess() async throws {
        repositoryMock.fetchNumberReturnValue = numberEntity()
        do {
            let value = try await sut.execute("")
            XCTAssertTrue(value.numberValue == 1)
        } catch {
            XCTFail("Test should success")
        }
    }
    
    func testExecuteIsOnlyOnceInvoked() async throws  {
        repositoryMock.fetchNumberReturnValue = numberEntity()
        let _ = try! await sut.execute("")
        XCTAssertTrue(repositoryMock.fetchNumberCallsCount == 1)
    }
    
    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: 1,
            numberFact: "1 is the value for this test")
    }
}
