//
//  FavoriteIconViewModelTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Combine
import XCTest
import Shared
@testable import FeatureNumbersView

final class FavoriteIconViewModelTest: XCTestCase {

    private lazy var cancellables = Set<AnyCancellable>()
    private var sut: FavoriteIconViewModel!
    private var isfavoriteNumberUseCaseMock = IsfavoriteNumberUseCaseTypeMock()
    private var deleteFavoriteUsecaseMock = DeleteFavoriteNumberUseCaseTypeMock()

    override func setUp() {
        super.setUp()
        sut = FavoriteIconViewModel(isFavorite: true,
                                    favoritesUseCase: isfavoriteNumberUseCaseMock,
                                    saveFavoritesUseCase: nil,
                                    deleteFavoritesUseCase: deleteFavoriteUsecaseMock)

    }


    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testFavoriteStateSuccess() {
        isfavoriteNumberUseCaseMock.executeReturnValue = true
        sut.trigger(.isFavorite("1"))

        XCTAssertTrue(sut.state.favoriteNumber)
    }

    func testFavoriteStateFails() {
        isfavoriteNumberUseCaseMock.executeReturnValue = false
        sut.trigger(.isFavorite("1"))

        XCTAssertFalse(sut.state.favoriteNumber)
    }

    func testDeleteStateFails() {

        let expectation = self.expectation(description: "ViewModel State")
        deleteFavoriteUsecaseMock.executeThrowableError = NumberViewError.wrongStatusCode
        var result: FavoriteIconViewModel.ViewState?

        sut.state.viewState

            .sink { _ in

        } receiveValue: { viewState in
            switch viewState {
            case .error:
                result = .error
                expectation.fulfill()
            default: break
            }
        }.store(in: &cancellables)


        sut.trigger(.delete(NumberRowViewEntity(numberValue: "",
                                                numberFact: "",
                                                isPrime: false)))
        waitForExpectations(timeout: 1)

        switch result {
        case .error:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }

    func testModifyNumberSuccess() {
        isfavoriteNumberUseCaseMock.executeReturnValue = false
        sut.trigger(.modifyNumber)

        XCTAssertFalse(sut.state.favoriteNumber)
    }

    func testFavoriteState() {
        isfavoriteNumberUseCaseMock.executeReturnValue = true

        let expectation = self.expectation(description: "ViewModel State")
        var result: FavoriteIconViewModel.ViewState?
        sut.state.viewState.sink { _ in

        } receiveValue: { viewState in
            result = viewState
            expectation.fulfill()
        }.store(in: &cancellables)
        sut.trigger(.isFavorite("1"))

        waitForExpectations(timeout: 2)

        switch result {
        case .favorite:
            break
        default:
            XCTFail("Invalid state. Received \(String(describing: result)) instead")
        }
    }
}
