//
//  RandomNumberViewmodeltest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 17/1/23.
//

import Combine
import XCTest
@testable import Numbers

final class RandomNumberViewmodeltest: XCTestCase {

    private lazy var cancellables = Set<AnyCancellable>()
    private var sut: RandomNumberViewModel!
    private var randomNumberUseCaseMock: RandomNumberUseCaseMock!
    private var randomNumberWithOperationUseCaseMock: RandomNumberWithOperationUseCaseMock!

    override  func setUp() {
        super.setUp()
        sut = RandomNumberViewModel()
        randomNumberUseCaseMock = RandomNumberUseCaseMock()
        randomNumberWithOperationUseCaseMock = RandomNumberWithOperationUseCaseMock()
        sut.randomNumberUsecase = randomNumberUseCaseMock
        sut.plusNumberUsecase = randomNumberWithOperationUseCaseMock
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
        sut = nil

    }

    @MainActor func testFetchRandomNumbersLoadingState() {
        let expectation = self.expectation(description: "ViewModel State")
        randomNumberUseCaseMock.returnValue = singleNumberEntity()

        var result: RandomNumberViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.randomNumber)

        waitForExpectations(timeout: 2)

        switch result {
        case .loading:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    @MainActor func testFetchRandomNumbersLoadedState() {
        let expectation = self.expectation(description: "ViewModel State")
        randomNumberUseCaseMock.returnValue = singleNumberEntity()

        var result: RandomNumberViewModel.ViewState?
        sut.state.viewState
            .dropFirst()
            .sink { _ in

            } receiveValue: { viewState in

                result = viewState
                expectation.fulfill()

            }.store(in: &cancellables)
        sut.trigger(.randomNumber)

        waitForExpectations(timeout: 2)

        switch result {
        case .loaded:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }


    private func singleNumberEntity() -> NumberEntity {
         NumberEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "1",
                       numberFact: "1 is the value for the test")

    }

}

private final class RandomNumberUseCaseMock: FetchRandomNumberUseCaseType {

    var returnValue: NumberEntity?
    var executeCallsCount = 0
    var isExecuteCalled: Bool {
        return executeCallsCount > 0
    }

    func execute() async throws -> Numbers.NumberEntity {
        executeCallsCount += 1
       return returnValue!
    }


}

private final class RandomNumberWithOperationUseCaseMock: FetchWithOperationNumberUseCaseType {
    var number = 43
    var executeCallsCount = 0
    var returnValue: NumberEntity?
    var isExecuteCalled: Bool {
        return executeCallsCount > 0
    }
    func execute(_ number: String) async throws -> Numbers.NumberEntity {

        returnValue!
    }


}
