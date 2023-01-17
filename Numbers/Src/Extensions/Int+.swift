//
//  Int+.swift
//  Numbers
//
//  Created by Michel Goñi on 17/1/23.
//

import Foundation

extension Int {

    var isPrime: Bool {
      guard self >= 2 else { return false }

      for i in 2..<self {
          if self % i == .zero {
          return false
        }
      }
      return true
    }
}
