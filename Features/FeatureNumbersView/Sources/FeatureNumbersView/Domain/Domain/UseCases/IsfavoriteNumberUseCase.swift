//
//  IsfavoriteNumberUseCase.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//

import Foundation
import NumbersEx

//sourcery: AutoMockable
public protocol IsfavoriteNumberUseCaseType {

    func execute(_ number: Int) -> Bool
}

//sourcery: AutoMockable
public final class IsfavoriteNumberUseCase: IsfavoriteNumberUseCaseType, UnwrappedUseCase {
    private var repository: NumberRepositoryType?

    init(repository: NumberRepositoryType?) {
        self.repository = repository
    }

    public func execute(_ number: Int) -> Bool {
        do {
            return try execute(repository?.isFavorite(number))
        } catch {
            return false
        }
    }
}

