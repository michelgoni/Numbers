//
//  NumbersAssemblerTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 14/1/23.
//

import XCTest
import Swinject
@testable import Numbers

final class NumbersAssemblerTest: XCTestCase {

    var sut: DependencyProvider!

    override func setUp() {
        super.setUp()
        sut = DependencyProvider()
    }

    func testRegisterUseCases() {
        XCTAssertNotNil(sut.container.resolve(FetchNumbersUseCaseType.self))
        XCTAssertNotNil(sut.container.resolve(FetchNumberUseCaseType.self))
        XCTAssertNotNil(sut.container.resolve(DeleteFavoriteNumberUseCaseType.self))
        XCTAssertNotNil(sut.container.resolve(FavoritesNumberUseCaseType.self))
        XCTAssertNotNil(sut.container.resolve(SaveFavoriteNumberUseCaseType.self))
        XCTAssertNotNil(sut.container.resolve(IsfavoriteNumberUseCaseType.self))
    }

    func testRegisterRepository() {
        XCTAssertNotNil(sut.container.resolve(NumberRepositoryType.self))
    }

    func testRegisterRemoteService() {
        XCTAssertNotNil(sut.container.resolve(RemoteDSType.self))
    }

    func testRegisterLocalService() {
        XCTAssertNotNil(sut.container.resolve(UserDefaultsDataSourceType.self))
    }

}
