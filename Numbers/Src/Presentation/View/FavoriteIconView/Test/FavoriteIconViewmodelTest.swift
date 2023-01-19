//
//  FavoriteIconViewmodelTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 17/1/23.
//

import Combine
import XCTest
@testable import Numbers

final class FavoriteIconViewmodelTest: XCTestCase {
    
    private lazy var cancellables = Set<AnyCancellable>()
    private var sut: FavoriteIconViewModel!
    private var isfavoriteNumberUseCaseMock: IsfavoriteNumberUseCaseMock!
    
    override  func setUp() {
        super.setUp()
        sut = FavoriteIconViewModel(isFavorite: true)
        isfavoriteNumberUseCaseMock = IsfavoriteNumberUseCaseMock()
        sut.favoritesUseCase = isfavoriteNumberUseCaseMock
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }


    func testFavoriteStateSuccess() {
        isfavoriteNumberUseCaseMock.returnValue = true
        sut.trigger(.isFavorite("1"))

        XCTAssertTrue(sut.state.favoriteNumber)
    }

    func testFavoriteStateFails() {
        isfavoriteNumberUseCaseMock.returnValue = false
        sut.trigger(.isFavorite("1"))

        XCTAssertFalse(sut.state.favoriteNumber)
    }

    func testModifyNumberSuccess() {
        isfavoriteNumberUseCaseMock.returnValue = true
        sut.trigger(.modifyNumber)
        XCTAssertFalse(sut.state.favoriteNumber)
    }

    func testFavoriteState() {
        isfavoriteNumberUseCaseMock.returnValue = true

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

private class IsfavoriteNumberUseCaseMock: IsfavoriteNumberUseCaseType {
    var returnValue: Bool?
    func execute(_ number: String) -> Bool {
        returnValue!
    }
}
