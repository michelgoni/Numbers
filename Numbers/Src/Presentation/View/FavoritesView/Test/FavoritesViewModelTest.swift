//
//  FavoritesViewModelTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 4/1/23.
//

import Combine
import XCTest
@testable import Numbers

final class FavoritesViewModelTest: XCTestCase, AwaitPublisher {

    lazy var cancellables = Set<AnyCancellable>()
    private var sut: FavoritesViewModel!
    private var deleteFavoriteUsecaseMock: DeleteFavoriteUsecaseMock!
    private var fetchFavoritesUseCaseMock: FetchFavoritesUseCaseMock!
    private var saveFavoritesUsecaseMock: SaveFavoritesUsecaseMock!

    override func setUp() {
        super.setUp()
        sut = FavoritesViewModel()
        deleteFavoriteUsecaseMock = DeleteFavoriteUsecaseMock()
        fetchFavoritesUseCaseMock = FetchFavoritesUseCaseMock()
        saveFavoritesUsecaseMock = SaveFavoritesUsecaseMock()
        
        sut.deleteFavoritesUseCase = deleteFavoriteUsecaseMock
        sut.saveFavoritesUseCase = saveFavoritesUsecaseMock
        sut.favoritesUseCase = fetchFavoritesUseCaseMock
    }

    override  func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testFetchFavoriteNumbersExecuteFails() {
        fetchFavoritesUseCaseMock.returnValue = .fail(.badResponse)
        let expected = try? awaitFailure(sut.favoritesUseCase.execute())
        switch expected {
        case .badResponse:
            break
        default:
            XCTFail("Invalid error")
        }
    }

    func testFetchFavoriteNumbersExecuteSuccess() throws {
        fetchFavoritesUseCaseMock.returnValue = .just(numberEntity())
        let expected = try awaitSuccess(sut.favoritesUseCase.execute())
        let value = numberEntity().first?.numberValue

        XCTAssertEqual(expected.first?.numberValue, value)
    }

    func testDeleteNumberExecuteSuccess() throws {
        deleteFavoriteUsecaseMock.returnValue = .just(numberEntity())
        let expected = try? awaitSuccess(sut.deleteFavoritesUseCase.execute(NumberEntity(
            id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
            isFavorite: true,
            isPrime: true,
            numberValue: "1",
            numberFact: "1 is the value for the test"))).first?.numberValue
        let value = try XCTUnwrap(numberEntity()).first?.numberValue
        let finalExpected = try XCTUnwrap(expected)
        XCTAssertEqual(finalExpected, value)
        
    }

    func testDeleteNumberExecuteFails() {
        deleteFavoriteUsecaseMock.returnValue = .fail(.badResponse)
        let expected = try? awaitFailure(sut.deleteFavoritesUseCase.execute(NumberEntity(
            id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
            isFavorite: true,
            isPrime: true,
            numberValue: "1",
            numberFact: "1 is the value for the test")))
        switch expected {
        case .badResponse:
            break
        default:
            XCTFail("Invalid error")
        }
    }

    func testSaveExecuteFails() {
        saveFavoritesUsecaseMock.throwError.toggle()
        do {
            try sut.saveFavoritesUseCase.execute(NumberEntity(
                id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                isFavorite: true,
                isPrime: true,
                numberValue: "1", numberFact: "1 is the value for the test"))
        } catch {
            XCTAssertTrue(error == NumbersError.badResponse)
        }
    }

    func testFetchFavoritesErrorState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchFavoritesUseCaseMock.returnValue = .fail(.badResponse)

        var result: FavoritesViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.favoritesList)

        waitForExpectations(timeout: 1)

        switch result {
        case .error:
            break
        default:
            XCTFail("Invalid state...")
        }
    }

    func testFetchFavoritesEmptyState() {
        let expectation = self.expectation(description: "ViewModel State")
        fetchFavoritesUseCaseMock.returnValue = .just([])

        var result: FavoritesViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.favoritesList)

        waitForExpectations(timeout: 1)

        switch result {
        case .emptyFavorites:
            break
        default:
            XCTFail("Invalid state...")
        }
    }

    

    private func numberEntity() -> [NumberEntity] {
        [ NumberEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "1", numberFact: "1 is the value for the test"),
          NumberEntity(id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "2", numberFact: "2 is the value for the test")
        ]
    }

}

class SaveFavoritesUsecaseMock: SaveFavoriteNumberUseCaseType {
    var throwError = true
    var returnLocalValue: NumbersError!
    func execute(_ data: Numbers.NumberEntity) throws {
        if throwError {
            throw returnLocalValue
        } else {
            return 
        }
    }
}

class DeleteFavoriteUsecaseMock: DeleteFavoriteNumberUseCaseType {
    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!
    func execute(_ data: Numbers.NumberEntity) -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        returnValue.eraseToAnyPublisher()
    }


}

class FetchFavoritesUseCaseMock: FavoritesNumberUseCaseType {
    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!
    func execute() -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        returnValue.eraseToAnyPublisher()
    }
}
