//
//  UserDefaultsDataSourceType.swift
//  Numbers
//
//  Created by Michel Goñi on 3/1/23.
//

import Foundation

protocol UserDefaultsDataSourceType {
    func fetchSavedNumbers() -> ResponsePublisher<[NumberEntity]>
    func delete(_ number: NumberEntity) -> ResponsePublisher<[NumberEntity]>
    func isFavorite(_ number: String) -> Bool
    func saveNumber(_ number: NumberEntity)  throws
}
