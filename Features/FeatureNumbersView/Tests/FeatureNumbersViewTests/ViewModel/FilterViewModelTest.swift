//
//  FilterViewModelTest.swift
//  
//
//  Created by Michel Goñi on 1/2/23.
//

import Combine
import XCTest
import NumbersEx

@testable import FeatureNumbersView

final class FilterViewModelTest: XCTestCase {

    private var sut: FilterNumbersViewModel!
    private var searchOperationalMock = SearchOperational()
    private lazy var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        sut = FilterNumbersViewModel(operational: searchOperationalMock)
    }


    func testValidFilterState() {
        var result: SearchOperational.Element?

        let expectation = self.expectation(description: "Test valid filter state")

        sut.operational.output.sink { element in
            result = element
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.trigger(.selectedNumberCategory(Category(description: "", tag: "even")))

        wait(for: [expectation], timeout: 1)

        switch result {
        case .validFilter(let filter):
            XCTAssertTrue(filter == "even")

        default:
            XCTFail("Invalid result")
        }
    }

    func testValidEmptyState() {
        var result: SearchOperational.Element?

        let expectation = self.expectation(description: "Test empty filter state")

        sut.operational.output.sink { element in
            result = element
            expectation.fulfill()
        }.store(in: &cancellables)

        sut.trigger(.selectedNumberCategory(nil))

        wait(for: [expectation], timeout: 1)

        switch result {
        case .validFilter(let filter):
            XCTAssertNil(filter)

        default:
            XCTFail("Invalid result")
        }
    }

}
