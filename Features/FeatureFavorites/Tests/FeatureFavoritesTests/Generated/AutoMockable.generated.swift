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
