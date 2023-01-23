//
//  NumberRepositoryImplm.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import Foundation
import NumbersEx

final class NumberRepositoryImplm: NumberRepositoryType {
    private var localDS: FetchNumberLocalDSType
    private var remoteDS: FetchNumberRemoteDSType

    init(localDS: FetchNumberLocalDSType,
         remoteDS: FetchNumberRemoteDSType) {
        self.localDS = localDS
        self.remoteDS = remoteDS
    }
    
    func fetchNumbers() async throws -> [NumberRowViewEntity] {

        let numberArray = Array(Set((0..<20)
            .map{ _ in Int.random(in: 1 ... 99) }))
            .map {String($0)}

        return try await remoteDS.fetchNumbers(numberArray)
            .map {
                let numberFact = String(decoding: $0, as: UTF8.self)
                let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
                return NumberRowViewEntity(numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
                                           numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "),
                                           isPrime: Int(number)?.isPrime ?? false)
            }
    }

    func fetchNumber(_ number: String)  async throws -> NumberRowViewEntity {
        let value = try await remoteDS.fetchNumber(number)
        let numberFact = String(decoding: value, as: UTF8.self)
        let number = numberFact.split(separator: Character(" ")).first?.description ?? ""
        return NumberRowViewEntity(numberValue: numberFact.split(separator: Character(" ")).first?.description ?? "",
                                   numberFact: numberFact.components(separatedBy: " ").dropFirst().joined(separator: " "),
                                   isPrime: Int(number)?.isPrime ?? false)

    }

}
