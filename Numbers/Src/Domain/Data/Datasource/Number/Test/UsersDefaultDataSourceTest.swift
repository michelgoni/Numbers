//
//  UsersDefaultDataSourceTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 3/1/23.
//
import Combine
import XCTest
@testable import Numbers

final class UsersDefaultDataSourceTest: XCTestCase {

    lazy var cancellables = Set<AnyCancellable>()
    var userDefaults: UserDefaults { UserDefaults(suiteName: "TestingUserDefaults")! }
    var sut: UserDefaultsDataSourceType!

    override func setUp() {
        super.setUp()

        //Credits to https://www.swiftbysundell.com/tips/avoiding-mocking-userdefaults/
        userDefaults.removePersistentDomain(forName: "TestingUserDefaults")
        sut = UserDefaultDataSource(userDefaults: userDefaults)
    }

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
        sut = nil
    }
}

extension UsersDefaultDataSourceTest {

    func testSaveNumberSuccess() {
        var testResult: NumberEntity!
        let expectation = self.expectation(description: "Save number expectation")

        try! sut.saveNumber(numberEntity())
        sut.fetchSavedNumbers().sink { _ in

        } receiveValue: { number in
            testResult = number.first
            expectation.fulfill()
        }
        .store(in: &cancellables)

        waitForExpectations(timeout: 1)
        XCTAssertTrue(testResult.numberValue == "1")
    }

    func testFetchNumberSuccess() {
        let expectation = self.expectation(description: "Fetch number expectation")

        sut.fetchSavedNumbers().sink { _ in

        } receiveValue: { number in
            expectation.fulfill()
            XCTAssertTrue(!number.isEmpty)

        }
        .store(in: &cancellables)

        waitForExpectations(timeout: 1)

    }

    func testDeleteNumberSuccess() {
        let expectation = self.expectation(description: "Delete number expectation")

        numberEntities().forEach {
            try! sut.saveNumber($0)
        }

        sut.delete(numberEntities().last!).sink { _ in

        } receiveValue: { numbers in
            expectation.fulfill()
            XCTAssertTrue(numbers.count == 1)

        } .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}


private extension UsersDefaultDataSourceTest {

    func wrongNumberEntity() -> NumberEntity {
        NumberEntity(id: UUID(uuidString: "")!, isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for the test")
    }

    func numberEntity() -> NumberEntity {
        NumberEntity(id: UUID(uuidString: "33041937-25b2-464a-98ad-3910cbe0d09e")!,
                     isFavorite: true,
                     isPrime: true,
                     numberValue: "1",
                     numberFact: "1 is the value for the test")
    }

    func numberEntities() -> [NumberEntity] {

        [ NumberEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "1",
                       numberFact: "1 is the value for the test"),
          NumberEntity(id: UUID(uuidString: "E621E1F8-C36C-495A-29FC-0C247A3E6E5F")!,
                       isFavorite: true,
                       isPrime: true,
                       numberValue: "2",
                       numberFact: "2 is the value for the test")
        ]
    }
}
