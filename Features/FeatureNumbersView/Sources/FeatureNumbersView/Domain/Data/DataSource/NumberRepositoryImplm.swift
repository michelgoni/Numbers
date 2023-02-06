//
//  NumberRepositoryImplm.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import NumbersEx
import Shared

final class NumberRepositoryImplm: NumberRepositoryType {


    private var localDS: FetchNumberLocalDSType?
    private var remoteDS: FetchNumberRemoteDSType?

    init(localDS: FetchNumberLocalDSType?,
         remoteDS: FetchNumberRemoteDSType?) {
        self.localDS = localDS
        self.remoteDS = remoteDS
    }

    func delete(_ number: NumberRowViewEntity) throws -> [NumberRowViewEntity] {
        try localDS?.delete(number) ?? []
    }
    
    func fetchNumbers() async throws -> [NumberRowViewEntity] {

        let numberArray = Array(Set((0..<20)
            .map{ _ in Int.random(in: 1 ... 99) }))
            .map {String($0)}
        guard let remoteDS = remoteDS else {
            throw NumberViewError.wronDependency("Check your depedency: missing \(String(describing: remoteDS)) dependency") }
        return try await remoteDS.fetchNumbers(numberArray)
            .map {
                let numberFact = String(decoding: $0, as: UTF8.self)
                let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
                return NumberRowViewEntity(numberValue: Int(number) ?? .zero,
                                           numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "))
            }
    }

    func fetchNumber(_ number: String)  async throws -> NumberRowViewEntity {
        guard let remoteDS = remoteDS else {
            throw NumberViewError.wronDependency("Check your depedency: missing \(String(describing: remoteDS)) dependency") }
        let value = try await remoteDS.fetchNumber(number)
        let numberFact = String(decoding: value, as: UTF8.self)
        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
        return NumberRowViewEntity(numberValue: Int(number) ?? .zero,
                                   numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "))

    }

    func isFavorite(_ number: Int) -> Bool {
        localDS?.isFavorite(number) ?? false
    }

    func saveNumber(_ number: NumberRowViewEntity) throws {
        do {
            try localDS?.saveNumber(number)

        } catch {
            throw error
        }
    }

}
