//
//  FeatureFavoritesAssemblerTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import XCTest
import NumbersInjector
@testable import FeatureFavorites

final class FeatureFavoritesAssemblerTest: XCTestCase {

    var sut: FeatureFavoritesAssembly!
    lazy var injector = NumbersInjector.shared

    override func setUp() {
        super.setUp()
        injector.apply([FeatureFavoritesAssembly()])
    }

    func testRegisterUseCases() {
        XCTAssertNotNil(injector.get(DeleteFavoriteNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(DeleteFavoriteNumberUseCaseType.self))
    }

    func testRegisterRepositories() {
        XCTAssertNotNil(injector.get(FavoriteNumbersRepositoryType.self))
    }

    func testRegisterLocalDS() {
        XCTAssertNotNil(injector.get(FetchNumberLocalDSType.self))
    }

}
