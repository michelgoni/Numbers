//
//  DeteleNumberUseCaseTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import Shared
import XCTest

@testable import FeatureNumbersView

final class IsFavoriteUseCaseTest: XCTestCase {

    var sut: IsfavoriteNumberUseCaseType!
    private var repositoryMock = NumbersRepositoryMock()

    override func setUp() {
        super.setUp()
        sut = IsfavoriteNumberUseCase(repository: repositoryMock)
    }

    func testExecuteSuccess() {
        let value =  sut.execute("")
       XCTAssertTrue(value)
    }

}
