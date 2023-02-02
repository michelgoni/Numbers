//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Foundation

final class PrimeNumberRepositoryImplm: PrimeNumberRepositoryType {

    private var remoteDS: IsPrimeRemoteDSType

    init(remoteDS: IsPrimeRemoteDSType) {
        self.remoteDS = remoteDS
    }
    
    func isPrime(_ number: Int) -> ResponsePublisher<Bool> {
        .just(true)
    }




}
