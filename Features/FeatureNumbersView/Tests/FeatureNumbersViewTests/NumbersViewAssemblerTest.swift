//
//  NumbersViewAssemblerTest.swift
//  
//
//  Created by Michel Goñi on 26/1/23.
//

import XCTest
import NumbersInjector
@testable import FeatureNumbersView

final class NumbersViewAssemblerTest: XCTestCase {

    var sut: FeatureNumbersAssembly!
    lazy var injector = NumbersInjector.shared

    override func setUp() {
        super.setUp()
        injector.apply([FeatureNumbersAssembly()])
    }

    func testRegisterUseCases() {
        XCTAssertNotNil(injector.get(FetchNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(DeleteFavoriteNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(FetchNumbersUseCaseType.self))
        XCTAssertNotNil(injector.get(FetchWithOperationNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(IsfavoriteNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(FetchRandomNumberUseCaseType.self))
        XCTAssertNotNil(injector.get(SaveFavoriteNumberUseCaseType.self))
    }

}
