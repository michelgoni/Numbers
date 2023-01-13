//
//  NumbersReposositoryTest.swift
//  NumbersTests
//
//  Created by Michel Goñi on 3/1/23.
//

import XCTest
import Combine
@testable import Numbers

final class NumbersReposositoryTest: XCTestCase, AwaitPublisher {

    var localMock: UserDefaultsDataSourceTypeMock = UserDefaultsDataSourceTypeMock()
    var remoteMock: RemoteDataSourceTypeMock = RemoteDataSourceTypeMock()
    var sut: NumbersRepository!
    lazy var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        sut = NumbersRepository()
        sut.localDS = localMock
        sut.remoteDS = remoteMock
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - LocalDS test
    func testIsLocalDSInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.fetchSavedNumbers()
        XCTAssertTrue(localMock.isInvoked)
    }

    func testFetchLocalNumberIsOnlyOnceInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.fetchSavedNumbers()
        XCTAssertTrue(localMock.isExecuteCalled)
    }

    func testDeleteLocalNumberIsInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.delete(number())
        XCTAssertTrue(localMock.isInvoked)
    }

    func testDeleteLocalNumberIsOnlyOnceInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.delete(number())
        XCTAssertTrue(localMock.isExecuteCalled)
    }

    func testDeleteLocalNumberFails() {
        localMock.returnValue = .fail(.badResponse)
        let value = try? awaitFailure(sut.delete(number()))
        switch value {
        case .badResponse:
            break
        default:
            XCTFail("Invalid error")
        }
    }

    func testFetchLocalSaveNumberFails() {
        localMock.returnValue = .fail(.badResponse)
        let value = try? awaitFailure(sut.fetchSavedNumbers())
        switch value {
        case .badResponse:
            break
        default:
            XCTFail("Invalid error")
        }
        XCTAssertTrue(localMock.isExecuteCalled)
    }

    func testSaveNumberFails() {
        localMock.returnLocalValue = .badResponse
        do {
            try sut.saveNumber(NumberEntity(isFavorite: true,
                                            isPrime: true,
                                            numberValue: "1",
                                            numberFact: "1 Fact"))
        } catch {
            XCTAssertTrue(error == NumbersError.badResponse)
        }
    }

    // MARK: - RemoteDS test
    func testIsRemoteDSInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.fetchSavedNumbers()
        XCTAssertTrue(localMock.isExecuteCalled)
    }

    func testFetchRemoteNumberIsOnlyOnceInvoked() {
        localMock.returnValue = .just([])
        let _ = sut.fetchNumbers()
        XCTAssertTrue(remoteMock.isExecuteCalled)
    }

    func testFetchRemoteNumberDoesNotMapProperly() {
        let json = """
                       {"aaa":""}
                       """
            .data(using: .utf8)!
        let sut = try? JSONDecoder().decode([NumberEntity].self, from: json)
        XCTAssertNil(sut)
    }

    func testFetchRemoteNumberMapsProperly() {

        sut.fetchNumbers()
            .sink { _ in

            } receiveValue: { numberEntity in
                XCTAssertTrue(!numberEntity.isEmpty)
            }
            .store(in: &cancellables)
    }

    // MARK: - Private

    private func savedNumbers() -> [NumberEntity] {
        [NumberEntity(isFavorite: true,
                      isPrime: true,
                      numberValue: "1", numberFact: "1 Fact"),
         NumberEntity(isFavorite: true,
                      isPrime: true,
                      numberValue: "2", numberFact: "2 Fact")]
    }

    private func savedNumber() -> [NumberEntity] {
        [NumberEntity(isFavorite: true,
                      isPrime: true,
                      numberValue: "1", numberFact: "1 Fact")]
    }

    private func number() -> NumberEntity {
        NumberEntity(isFavorite: true,
                     isPrime: true,
                     numberValue: "1", numberFact: "1 Fact")
    }
}

// MARK: -Mock

class RemoteDataSourceTypeMock: RemoteDSType {

    var urlSession: URLSession = URLSession.shared

    var isInvoked = false
    var callCount = 0
    var isExecuteCalled: Bool {
        return callCount > 0
    }
    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!

    func fetchNumbersAsync(_ numbers: [String]) async throws -> [Data] {

        []
    }

    func fetchNumbers(_ numbers: [String]) -> Numbers.ResponsePublisher<[Data]> {
        isInvoked = true
        callCount += 1
        return Deferred {
            Future<[Data], NumbersError> { promise in
                let value =  [NumberEntity(isFavorite: true,
                                           isPrime: true,
                                           numberValue: "1", numberFact: "1 Fact")]
                let data = try! JSONEncoder().encode(value)

                promise(.success([data]))
            }
        }.eraseToAnyPublisher()
    }
}

class UserDefaultsDataSourceTypeMock: UserDefaultsDataSourceType {

    var isInvoked = false
    var callCount = 0
    var isExecuteCalled: Bool {
        return callCount > 0
    }
    var returnValue: Numbers.ResponsePublisher<[Numbers.NumberEntity]>!
    var returnLocalValue: NumbersError!
    func fetchSavedNumbers() -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        isInvoked.toggle()
        callCount += 1
        return returnValue.eraseToAnyPublisher()
    }
    

    func delete(_ number: Numbers.NumberEntity) -> Numbers.ResponsePublisher<[Numbers.NumberEntity]> {
        callCount += 1
        isInvoked.toggle()
        return returnValue.eraseToAnyPublisher()
    }

    func isFavorite(_ number: String) -> Bool {
        false
    }

    func saveNumber(_ number: Numbers.NumberEntity) throws {
        throw returnLocalValue
    }
}


