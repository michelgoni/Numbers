//
//  File.swift
//  
//
//  Created by Michel Goñi on 2/2/23.
//

import Combine
import Foundation
import NumbersEx

public typealias ResponsePublisher<T> = AnyPublisher<T, Error>

protocol IsPrimeRemoteDSType {
    var urlSession: URLSession { get }
    func isNumberPrime(_ number: Int) -> ResponsePublisher<Bool>
}

final class IsPrimeRemoteDSImplm: IsPrimeRemoteDSType {

    var urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func isNumberPrime(_ number: Int) -> ResponsePublisher<Bool> {

        .just(true)

    }


}
