//
//  NumbersViewModelTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Combine
import XCTest
import NumbersEx
import Shared
@testable import FeatureNumbersView

final class NumbersViewModelTest: XCTestCase {

    lazy var cancellables = Set<AnyCancellable>()
    private var sut: NumbersViewModel!
    private var fetchNumbersUseCaseMock = FetchNumbersUseCaseTypeMock()
    private var fetchNumberUseCaseMock = FetchNumberUseCaseTypeMock()

    override func setUp() {
        super.setUp()
        sut = NumbersViewModel(numbersUseCase: fetchNumbersUseCaseMock,
                               numberUseCase: fetchNumberUseCaseMock)
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
        sut = nil

    }

    @MainActor func testFetchNumbersLoadingState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumbersUseCaseMock.executeReturnValue = []

        var result: NumbersViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.numbersList)

        waitForExpectations(timeout: 2)

        switch result {
        case .loading:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    @MainActor func testFetchNumberLoadingState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumberUseCaseMock.executeReturnValue = NumberRowViewEntity(numberValue: .zero,
                                                                        numberFact: "",
                                                                        isPrime: false)

        var result: NumbersViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.searchNumber(""))

        waitForExpectations(timeout: 2)

        switch result {
        case .loading:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    @MainActor func testFetchNumbersErrorState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumbersUseCaseMock.executeThrowableError = NumberViewError.wrongStatusCode

        var result: NumbersViewModel.ViewState?

        sut.state.viewState.sink { completion in

        } receiveValue: { viewState in
            switch viewState {
            case .error:
                result = .error
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)
        sut.trigger(.numbersList)
        waitForExpectations(timeout: 1.1)

        switch result {
        case .error:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    @MainActor func testFetchNumberErrorState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumberUseCaseMock.executeThrowableError = NumberViewError.wrongStatusCode

        var result: NumbersViewModel.ViewState?

        sut.state.viewState.sink { completion in

        } receiveValue: { viewState in
            switch viewState {
            case .error:
                result = .error
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)
        sut.trigger(.searchNumber(""))
        waitForExpectations(timeout: 1.1)

        switch result {
        case .error:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }
}

