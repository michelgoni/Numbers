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

@testable import FeatureFavorites














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
class FavoriteNumbersRepositoryTypeMock: FavoriteNumbersRepositoryType {

    //MARK: - delete

    var deleteThrowableError: Error?
    var deleteCallsCount = 0
    var deleteCalled: Bool {
        return deleteCallsCount > 0
    }
    var deleteReceivedNumber: NumberRowViewEntity?
    var deleteReceivedInvocations: [NumberRowViewEntity] = []
    var deleteReturnValue: [NumberRowViewEntity]?
    var deleteClosure: ((NumberRowViewEntity) throws -> [NumberRowViewEntity]?)?

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity]? {
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

    //MARK: - fetchFavoritesList

    var fetchFavoritesListThrowableError: Error?
    var fetchFavoritesListCallsCount = 0
    var fetchFavoritesListCalled: Bool {
        return fetchFavoritesListCallsCount > 0
    }
    var fetchFavoritesListReturnValue: [NumberRowViewEntity]?
    var fetchFavoritesListClosure: (() throws -> [NumberRowViewEntity]?)?

    func fetchFavoritesList() throws -> [NumberRowViewEntity]? {
        if let error = fetchFavoritesListThrowableError {
            throw error
        }
        fetchFavoritesListCallsCount += 1
        if let fetchFavoritesListClosure = fetchFavoritesListClosure {
            return try fetchFavoritesListClosure()
        } else {
            return fetchFavoritesListReturnValue
        }
    }

}
class FavoritesNumberUseCaseTypeMock: FavoritesNumberUseCaseType {

    //MARK: - execute

    var executeThrowableError: Error?
    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: [NumberRowViewEntity]?
    var executeClosure: (() throws -> [NumberRowViewEntity]?)?

    func execute() throws -> [NumberRowViewEntity]? {
        if let error = executeThrowableError {
            throw error
        }
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return try executeClosure()
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

}
