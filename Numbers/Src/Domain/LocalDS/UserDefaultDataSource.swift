//
//  UserDefaultDataSource.swift
//  Numbers
//
//  Created by Michel Goñi on 3/1/23.
//

import Foundation
import Combine
import SwiftUI

final class UserDefaultDataSource: UserDefaultsDataSourceType {

    private let userDefaults: UserDefaults
    private var numbers = [NumberEntity]()
    @AppStorage("") private var savedNumbers = Data()

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaultDataSource {

    func delete(_ number: NumberEntity) -> ResponsePublisher<[NumberEntity]> {
        numbers.removeAll { $0.numberValue == number.numberValue }
        do {
            savedNumbers = try encode(numbers)
        } catch {
            return .fail(NumbersError.encodingError)
        }

        return Deferred {
            Future<[NumberEntity], NumbersError> { promise in
                if self.numbers.isEmpty {
                    promise(.success([]))
                } else {
                    guard let numbers = try? JSONDecoder()
                        .decode([NumberEntity].self,
                                from: self.savedNumbers) else {
                        promise(.failure(.empty))
                        return
                    }
                    promise(.success(numbers))
                }
            }
        }.eraseToAnyPublisher()
    }

    func fetchSavedNumbers() -> ResponsePublisher<[NumberEntity]> {

        return Deferred {
            Future<[NumberEntity], NumbersError> { promise in
                guard let numbers = try? JSONDecoder()
                    .decode([NumberEntity].self,
                            from: self.savedNumbers),
                      !numbers.isEmpty else {
                    promise(.success([]))
                    return
                }
                self.numbers = numbers
                promise(.success(numbers))
            }
        }.eraseToAnyPublisher()
    }

    func isFavorite(_ number: String) -> Bool {
        guard let numbers = try? JSONDecoder()
            .decode([NumberEntity].self, from: self.savedNumbers),
                !numbers.isEmpty else {
            return false
        }
        return numbers.contains { $0.numberValue == number }
    }

    func saveNumber(_ number: NumberEntity) throws {

        if !numbers.contains(where: { $0.numberValue == number.numberValue }) {
            numbers.append(number)
            savedNumbers = try encode(numbers)
        }
    }

    private func encode(_ numbers: [NumberEntity]) throws  -> Data {
        guard let numbers = try? JSONEncoder()
            .encode(numbers) else { throw NumbersError.encodingError }
        return numbers
    }
}

private struct UserDefaultDataSourceKey: InjectionKey {
    static var currentValue: UserDefaultsDataSourceType = UserDefaultDataSource(userDefaults: UserDefaults.standard)
}

extension InjectedValues {
    var localDS: UserDefaultsDataSourceType {
        get { Self[UserDefaultDataSourceKey.self] }
        set { Self[UserDefaultDataSourceKey.self] = newValue }
    }
}
