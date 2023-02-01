// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Shared

@testable import FeatureNumbersView














class DeleteFavoriteNumberUseCaseTypeMock: DeleteFavoriteNumberUseCaseType {

    //MARK: - execute

    var executeThrowableError: Error?
    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReceivedData: NumberRowViewEntity?
    var executeReceivedInvocations: [NumberRowViewEntity] = []
    var executeReturnValue: [NumberRowViewEntity]!
    var executeClosure: ((NumberRowViewEntity) throws -> [NumberRowViewEntity])?

    func execute(_ data: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        executeReceivedData = data
        executeReceivedInvocations.append(data)
        if let executeClosure = executeClosure {
            return try executeClosure(data)
        } else {
            return executeReturnValue
        }
    }

}
class FetchNumberLocalDSTypeMock: FetchNumberLocalDSType {

    //MARK: - delete

    var deleteThrowableError: Error?
    var deleteCallsCount = 0
    var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    var deleteReceivedNumber: NumberRowViewEntity?
    var deleteReceivedInvocations: [NumberRowViewEntity] = []
    var deleteReturnValue: [NumberRowViewEntity]!
    var deleteClosure: ((NumberRowViewEntity) throws -> [NumberRowViewEntity])?

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        if let error = deleteThrowableError {
            throw error
        }
        deleteCallsCount += 1
        deleteReceivedNumber = number
        deleteReceivedInvocations.append(number)
        if let deleteClosure = deleteClosure {
            return try deleteClosure(number)
        } else {
            return deleteReturnValue
        }
    }

    //MARK: - fetchSavedNumbers

    var fetchSavedNumbersThrowableError: Error?
    var fetchSavedNumbersCallsCount = 0
    var fetchSavedNumbersCalled: Bool {
        return fetchSavedNumbersCallsCount > 0
    }
    var fetchSavedNumbersReturnValue: [NumberRowViewEntity]!
    var fetchSavedNumbersClosure: (() throws -> [NumberRowViewEntity])?

    func fetchSavedNumbers() throws -> [NumberRowViewEntity] {
        if let error = fetchSavedNumbersThrowableError {
            throw error
        }
        fetchSavedNumbersCallsCount += 1
        if let fetchSavedNumbersClosure = fetchSavedNumbersClosure {
            return try fetchSavedNumbersClosure()
        } else {
            return fetchSavedNumbersReturnValue
        }
    }

    //MARK: - isFavorite

    var isFavoriteCallsCount = 0
    var isFavoriteCalled: Bool {
        return isFavoriteCallsCount > 0
    }
    var isFavoriteReceivedNumber: Int?
    var isFavoriteReceivedInvocations: [Int] = []
    var isFavoriteReturnValue: Bool!
    var isFavoriteClosure: ((Int) -> Bool)?

    func isFavorite(_ number: Int) -> Bool {
        isFavoriteCallsCount += 1
        isFavoriteReceivedNumber = number
        isFavoriteReceivedInvocations.append(number)
        if let isFavoriteClosure = isFavoriteClosure {
            return isFavoriteClosure(number)
        } else {
            return isFavoriteReturnValue
        }
    }

    //MARK: - saveNumber

    var saveNumberThrowableError: Error?
    var saveNumberCallsCount = 0
    var saveNumberCalled: Bool {
        return saveNumberCallsCount > 0
    }
    var saveNumberReceivedNumber: NumberRowViewEntity?
    var saveNumberReceivedInvocations: [NumberRowViewEntity] = []
    var saveNumberClosure: ((NumberRowViewEntity) throws -> Void)?

    func saveNumber(_ number: NumberRowViewEntity) throws {
        if let error = saveNumberThrowableError {
            throw error
        }
        saveNumberCallsCount += 1
        saveNumberReceivedNumber = number
        saveNumberReceivedInvocations.append(number)
        try saveNumberClosure?(number)
    }

}
class FetchNumberRemoteDSTypeMock: FetchNumberRemoteDSType {
    var urlSession: URLSession {
        get { return underlyingUrlSession }
        set(value) { underlyingUrlSession = value }
    }
    var underlyingUrlSession: URLSession!

    //MARK: - fetchNumbers

    var fetchNumbersThrowableError: Error?
    var fetchNumbersCallsCount = 0
    var fetchNumbersCalled: Bool {
        return fetchNumbersCallsCount > 0
    }
    var fetchNumbersReceivedNumbers: [String]?
    var fetchNumbersReceivedInvocations: [[String]] = []
    var fetchNumbersReturnValue: [Data]!
    var fetchNumbersClosure: (([String]) async throws -> [Data])?

    func fetchNumbers(_ numbers: [String]) async throws -> [Data] {
        if let error = fetchNumbersThrowableError {
            throw error
        }
        fetchNumbersCallsCount += 1
        fetchNumbersReceivedNumbers = numbers
        fetchNumbersReceivedInvocations.append(numbers)
        if let fetchNumbersClosure = fetchNumbersClosure {
            return try await fetchNumbersClosure(numbers)
        } else {
            return fetchNumbersReturnValue
        }
    }

    //MARK: - fetchNumber

    var fetchNumberThrowableError: Error?
    var fetchNumberCallsCount = 0
    var fetchNumberCalled: Bool {
        return fetchNumberCallsCount > 0
    }
    var fetchNumberReceivedNumber: String?
    var fetchNumberReceivedInvocations: [String] = []
    var fetchNumberReturnValue: Data!
    var fetchNumberClosure: ((String) async throws -> Data)?

    func fetchNumber(_ number: String) async throws -> Data {
        if let error = fetchNumberThrowableError {
            throw error
        }
        fetchNumberCallsCount += 1
        fetchNumberReceivedNumber = number
        fetchNumberReceivedInvocations.append(number)
        if let fetchNumberClosure = fetchNumberClosure {
            return try await fetchNumberClosure(number)
        } else {
            return fetchNumberReturnValue
        }
    }

}
class FetchNumberUseCaseTypeMock: FetchNumberUseCaseType {

    //MARK: - execute

    var executeThrowableError: Error?
    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReceivedNumber: String?
    var executeReceivedInvocations: [String] = []
    var executeReturnValue: NumberRowViewEntity!
    var executeClosure: ((String) async throws -> NumberRowViewEntity)?

    func execute(_ number: String) async throws -> NumberRowViewEntity {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        executeReceivedNumber = number
        executeReceivedInvocations.append(number)
        if let executeClosure = executeClosure {
            return try await executeClosure(number)
        } else {
            return executeReturnValue
        }
    }

}
class FetchNumbersUseCaseTypeMock: FetchNumbersUseCaseType {

    //MARK: - execute

    var executeThrowableError: Error?
    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: [NumberRowViewEntity]!
    var executeClosure: (() async throws -> [NumberRowViewEntity])?

    func execute() async throws -> [NumberRowViewEntity] {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return try await executeClosure()
        } else {
            return executeReturnValue
        }
    }

}
class IsfavoriteNumberUseCaseTypeMock: IsfavoriteNumberUseCaseType {

    //MARK: - execute

    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReceivedNumber: Int?
    var executeReceivedInvocations: [Int] = []
    var executeReturnValue: Bool!
    var executeClosure: ((Int) -> Bool)?

    func execute(_ number: Int) -> Bool {
        executeCallsCount += 1
        executeReceivedNumber = number
        executeReceivedInvocations.append(number)
        if let executeClosure = executeClosure {
            return executeClosure(number)
        } else {
            return executeReturnValue
        }
    }

}
class NumberRepositoryTypeMock: NumberRepositoryType {

    //MARK: - delete

    var deleteThrowableError: Error?
    var deleteCallsCount = 0
    var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    var deleteReceivedNumber: NumberRowViewEntity?
    var deleteReceivedInvocations: [NumberRowViewEntity] = []
    var deleteReturnValue: [NumberRowViewEntity]!
    var deleteClosure: ((NumberRowViewEntity) throws -> [NumberRowViewEntity])?

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        if let error = deleteThrowableError {
            throw error
        }
        deleteCallsCount += 1
        deleteReceivedNumber = number
        deleteReceivedInvocations.append(number)
        if let deleteClosure = deleteClosure {
            return try deleteClosure(number)
        } else {
            return deleteReturnValue
        }
    }

    //MARK: - fetchNumbers

    var fetchNumbersThrowableError: Error?
    var fetchNumbersCallsCount = 0
    var fetchNumbersCalled: Bool {
        return fetchNumbersCallsCount > 0
    }
    var fetchNumbersReturnValue: [NumberRowViewEntity]!
    var fetchNumbersClosure: (() async throws -> [NumberRowViewEntity])?

    func fetchNumbers() async throws -> [NumberRowViewEntity] {
        if let error = fetchNumbersThrowableError {
            throw error
        }
        fetchNumbersCallsCount += 1
        if let fetchNumbersClosure = fetchNumbersClosure {
            return try await fetchNumbersClosure()
        } else {
            return fetchNumbersReturnValue
        }
    }

    //MARK: - fetchNumber

    var fetchNumberThrowableError: Error?
    var fetchNumberCallsCount = 0
    var fetchNumberCalled: Bool {
        return fetchNumberCallsCount > 0
    }
    var fetchNumberReceivedNumber: String?
    var fetchNumberReceivedInvocations: [String] = []
    var fetchNumberReturnValue: NumberRowViewEntity!
    var fetchNumberClosure: ((String) async throws -> NumberRowViewEntity)?

    func fetchNumber(_ number: String) async throws -> NumberRowViewEntity {
        if let error = fetchNumberThrowableError {
            throw error
        }
        fetchNumberCallsCount += 1
        fetchNumberReceivedNumber = number
        fetchNumberReceivedInvocations.append(number)
        if let fetchNumberClosure = fetchNumberClosure {
            return try await fetchNumberClosure(number)
        } else {
            return fetchNumberReturnValue
        }
    }

    //MARK: - isFavorite

    var isFavoriteCallsCount = 0
    var isFavoriteCalled: Bool {
        return isFavoriteCallsCount > 0
    }
    var isFavoriteReceivedNumber: Int?
    var isFavoriteReceivedInvocations: [Int] = []
    var isFavoriteReturnValue: Bool!
    var isFavoriteClosure: ((Int) -> Bool)?

    func isFavorite(_ number: Int) -> Bool {
        isFavoriteCallsCount += 1
        isFavoriteReceivedNumber = number
        isFavoriteReceivedInvocations.append(number)
        if let isFavoriteClosure = isFavoriteClosure {
            return isFavoriteClosure(number)
        } else {
            return isFavoriteReturnValue
        }
    }

    //MARK: - saveNumber

    var saveNumberThrowableError: Error?
    var saveNumberCallsCount = 0
    var saveNumberCalled: Bool {
        return saveNumberCallsCount > 0
    }
    var saveNumberReceivedNumber: NumberRowViewEntity?
    var saveNumberReceivedInvocations: [NumberRowViewEntity] = []
    var saveNumberClosure: ((NumberRowViewEntity) throws -> Void)?

    func saveNumber(_ number: NumberRowViewEntity) throws {
        if let error = saveNumberThrowableError {
            throw error
        }
        saveNumberCallsCount += 1
        saveNumberReceivedNumber = number
        saveNumberReceivedInvocations.append(number)
        try saveNumberClosure?(number)
    }

}
class SaveFavoriteNumberUseCaseTypeMock: SaveFavoriteNumberUseCaseType {

    //MARK: - execute

    var executeThrowableError: Error?
    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReceivedData: NumberRowViewEntity?
    var executeReceivedInvocations: [NumberRowViewEntity] = []
    var executeClosure: ((NumberRowViewEntity) throws -> Void)?

    func execute(_ data: NumberRowViewEntity) throws {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        executeReceivedData = data
        executeReceivedInvocations.append(data)
        try executeClosure?(data)
    }

}
