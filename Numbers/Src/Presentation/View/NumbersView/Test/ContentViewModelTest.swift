//
//  ContentViewModelTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import Combine
import XCTest
@testable import Numbers

final class ContentViewModelTest: XCTestCase, AwaitPublisher {

    lazy var cancellables = Set<AnyCancellable>()
    private var sut: NumbersViewModel!
    private var fetchNumbersUseCaseMock: FetchNumbersUseCaseMock!
    private var fetchNumberUseCaseMock: FetchNumberUseCaseMock!

    override func setUp() {
        super.setUp()
        sut = NumbersViewModel()
        fetchNumbersUseCaseMock = FetchNumbersUseCaseMock()
        fetchNumberUseCaseMock = FetchNumberUseCaseMock()
        sut.numbersUseCase = fetchNumbersUseCaseMock
        sut.numberUseCase = fetchNumberUseCaseMock
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
        sut = nil

    }

    @MainActor func testFetchNumbersAsyncExecutes() async {

        sut.trigger(.numbersList)

        let expected = try? await sut.numbersUseCase.execute()
        let value = numberEntity()

        XCTAssertEqual(expected?.first?.numberValue, value.first?.numberValue)
    }

    @MainActor func testFetchNumbersExecutes() {

        fetchNumbersUseCaseMock.returnValue = .just(numberEntity())

        sut.trigger(.numbersList)
        let expected = try? awaitSuccess(sut.numbersUseCase.execute())
        let value = numberEntity()

        XCTAssertEqual(expected?.first?.numberValue, value.first?.numberValue)
    }

    @MainActor func testFetchSingleNumberExecutes() {

        fetchNumberUseCaseMock.returnValue = .just(singleNumberEntity())

        sut.trigger(.singleNumber("1"))
        let expected = try? awaitSuccess(sut.numberUseCase.execute("1"))
        let value = singleNumberEntity()

        XCTAssertEqual(expected?.first?.numberValue, value.first?.numberValue)

    }


    @MainActor func testFetchNumbersLoadingState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumbersUseCaseMock.returnValue = .just([])

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

    @MainActor func testFetchNumberErrorState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchNumberUseCaseMock.returnValue = .fail(.badResponse)

        var result: NumbersViewModel.ViewState?
        sut.state.viewState
            .dropFirst()
            .collect(2)
            .sink { _ in

        } receiveValue: { viewState in
            if viewState.contains(.error) {
                result = .error
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        sut.trigger(.singleNumber("1"))

        waitForExpectations(timeout: 1)

        switch result {
        case .error:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }


    private func numberEntity() -> [NumberEntity] {
        [ NumberEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "1",
                       numberFact: "1 is the value for the test"),
          NumberEntity(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "2",
                       numberFact: "2 is the value for the test")
        ]
    }

    private func singleNumberEntity() -> [NumberEntity] {
        [ NumberEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "1",
                       numberFact: "1 is the value for the test")
        ]
    }

}

class FetchNumbersUseCaseMock: FetchNumbersUseCaseType {

    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!
    var throwError = false
   

    func execute() async throws -> [Numbers.NumberEntity] {

        switch throwError {
        case true:
            throw NumbersError.badResponse
        case false:
            return [NumberEntity(isFavorite: true, isPrime: true, numberValue: "1", numberFact: "")]
        }
    }

    func execute() -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        
        returnValue.eraseToAnyPublisher()
    }
}

class FetchNumberUseCaseMock: FetchNumberUseCaseType {

    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!

    func execute(_ number: String) -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        returnValue.eraseToAnyPublisher()
    }
}


