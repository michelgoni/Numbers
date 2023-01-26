//
//  LocalDSTest.swift
//  
//
//  Created by Michel Goñi on 25/1/23.
//

import Shared
import XCTest
@testable import FeatureNumbersView


final class LocalDSTest: XCTestCase {

    var userDefaults: UserDefaults { UserDefaults(suiteName: "TestingUserDefaults")! }
    var sut: FetchNumberLocalDSType!

    override func setUp() {
        super.setUp()

        //Credits to https://www.swiftbysundell.com/tips/avoiding-mocking-userdefaults/
        userDefaults.removePersistentDomain(forName: "TestingUserDefaults")
        sut = FetchNumberLocalDSImplm(userDefaults: UserDefaults.standard)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

extension LocalDSTest {

    func testSaveNumberSuccess() {
        var testResult: NumberRowViewEntity!
        try! sut.saveNumber(numberEntity())
        testResult = try! sut.fetchSavedNumbers().first!
       XCTAssertTrue(testResult.numberValue == "1")
    }

    func testFetchNumberSuccess() {
        var testResult: [NumberRowViewEntity]!
        testResult = try! sut.fetchSavedNumbers()
        XCTAssertTrue(!testResult.isEmpty)
    }
}


private extension LocalDSTest {

    func wrongNumberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(id: UUID(uuidString: "")!,
                            numberValue: "1",
                            numberFact: "1 is the value for the test",
                            isPrime: true)
    }

    func numberEntity() -> NumberRowViewEntity {
        NumberRowViewEntity(id: UUID(uuidString: "33041937-25b2-464a-98ad-3910cbe0d09e")!,
                            numberValue: "1",
                            numberFact: "1 is the value for the test",
                            isPrime: true)
    }

    func numberEntities() -> [NumberRowViewEntity] {

        [ NumberRowViewEntity(id: UUID(uuidString: "33041937-05b2-464a-98ad-3910cbe0d09e")!,
                              numberValue: "1",
                              numberFact: "1 is the value for the test",
                              isPrime: true),
          NumberRowViewEntity(id: UUID(uuidString: "E621E1F8-C36C-495A-29FC-0C247A3E6E5F")!,
                              numberValue: "2",
                              numberFact: "2 is the value for the test",
                              isPrime: true)
        ]
    }
}

