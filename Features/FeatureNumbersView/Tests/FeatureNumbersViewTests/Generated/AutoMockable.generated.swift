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
    var isFavoriteReceivedNumber: String?
    var isFavoriteReceivedInvocations: [String] = []
    var isFavoriteReturnValue: Bool!
    var isFavoriteClosure: ((String) -> Bool)?

    func isFavorite(_ number: String) -> Bool {
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
