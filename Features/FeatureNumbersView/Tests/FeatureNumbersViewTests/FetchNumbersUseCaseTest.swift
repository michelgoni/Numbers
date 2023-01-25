//
//  FetchNumbersUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import Combine
import Shared
import XCTest

@testable import FeatureNumbersView



final class FetchNumbersUseCaseTest: XCTestCase {
    
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
    
    func testExecuteFailure() {
        //        repositoryMock.returnValue = .fail(.badResponse)
        //        let value = try? awaitFailure(sut.execute())
        //
        //        switch value {
        //        case .badResponse:
        //            break
        //        default:
        //            XCTFail("Invalid error")
        //        }
    }
    
    func testExecuteSuccess() throws {
        //        let expected = [numberEntity()]
        //        repositoryMock.returnValue = .just(expected)
        //        let value = try? awaitSuccess(sut.execute())
        //        let finalValue = try XCTUnwrap(value?.first?.numberValue)
        //        let finalExpected = try XCTUnwrap(expected).first?.numberValue
        //        XCTAssertEqual(finalExpected, finalValue)
        
    }
    
    func testExecuteIsOnlyOnceInvoked() {
        //        let expected = [numberEntity()]
        //        repositoryMock.returnValue = .just(expected)
        //        let _ = try? awaitSuccess(sut.execute())
        //        XCTAssertTrue(repositoryMock.isExecuteCalled)
        
    }
    
    private func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(
            numberValue: "1",
            numberFact: "1 is the value for this test",
            isPrime: true)
    }
    
}

class NumbersRepositoryMock: NumberRepositoryType {
    func fetchNumbers() async throws -> [NumberRowViewEntity] {
        []
    }
    
    func fetchNumber(_ number: String) async throws -> NumberRowViewEntity {
        NumberRowViewEntity(numberValue: "", numberFact: "", isPrime: false)
    }
    
    func isFavorite(_ number: String) -> Bool {
        false
    }
    
    func saveNumber(_ number: NumberRowViewEntity) throws {
        
    }
    
    
}
