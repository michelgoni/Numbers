//
//  FavoritesViewModelTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Combine
import XCTest
import NumbersEx
import Shared

@testable import FeatureFavorites

final class FavoritesViewModelTest: XCTestCase {

    var sut: FavoritesViewModel!
    var favoriteNumberUseCaseMock = FavoriteNumberUseCaseMock()
    var deleteFavoriteNumberUsecaseMock = DeleteFavoriteNumberUsecaseMock()
    private lazy var cancellables = Set<AnyCancellable>()

    override func setUp() {
        sut = FavoritesViewModel(favoritesUseCase: favoriteNumberUseCaseMock,
                                 deleteFavoritesUseCase: deleteFavoriteNumberUsecaseMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testDeleteEmptyStateSuccess() {
        deleteFavoriteNumberUsecaseMock.emptyState = true
        let expectation = self.expectation(description: "ViewModel State")
        var result: FavoritesViewModel.ViewState?

        sut.state.viewState.sink { viewState in
            switch viewState {
            case .emptyFavorites:
                result = viewState
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)

        sut.trigger(.delete(numberRowEntity()))
        waitForExpectations(timeout: 1)

        switch result {
        case .emptyFavorites:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    func testDeleteNonEmptyStateSuccess() {

        let expectation = self.expectation(description: "ViewModel State")
        var result: FavoritesViewModel.ViewState?

        sut.state.viewState.sink { viewState in
            switch viewState {
            case .favorites:
                result = viewState
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)

        sut.trigger(.delete(numberRowEntity()))
        waitForExpectations(timeout: 1)

        switch result {
        case .favorites:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    func testFavoriteListStateSuccess() {

        let expectation = self.expectation(description: "ViewModel State")
        var result: FavoritesViewModel.ViewState?
        sut.state.viewState.sink { viewState in
            switch viewState {
            case .favorites:
                result = viewState
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)
        sut.trigger(.favoritesList)
        waitForExpectations(timeout: 1)

        switch result {
        case .favorites:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    private func numberRowEntity() -> NumberRowViewEntity {

        NumberRowViewEntity(numberValue: "1", numberFact: "1", isPrime: true)
    }

}

class FavoriteNumberUseCaseMock: FavoritesNumberUseCaseType {
    func execute() throws -> [NumberRowViewEntity]? {
        return [
            NumberRowViewEntity(numberValue: "2", numberFact: "2 is the second fact", isPrime: false),
            NumberRowViewEntity(numberValue: "3", numberFact: "3 is the third fact", isPrime: false),
            NumberRowViewEntity(numberValue: "24", numberFact: "24 is the 24th fact", isPrime: true)
        ]
    }


}

class DeleteFavoriteNumberUsecaseMock: DeleteFavoriteNumberUseCaseType {
    var emptyState = false
    func execute(_ data: Shared.NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        if emptyState {
            return []
        } else {
            return [
                NumberRowViewEntity(numberValue: "2", numberFact: "2 is the second fact", isPrime: false),
                NumberRowViewEntity(numberValue: "3", numberFact: "3 is the third fact", isPrime: false),
                NumberRowViewEntity(numberValue: "24", numberFact: "24 is the 24th fact", isPrime: true)
            ]
        }

    }
}
