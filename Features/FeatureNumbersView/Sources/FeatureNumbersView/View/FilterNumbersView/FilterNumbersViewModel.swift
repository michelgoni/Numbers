//
//  FilterNumbersViewModel.swift
//  
//
//  Created by Michel Goñi on 31/1/23.
//

import Foundation
import NumbersEx

 final class FilterNumbersViewModel: ViewModel {

    @Published  var state: State
    let operational: SearchOperational

     init (operational: SearchOperational, categories: [Category]) {
        self.state = State(categories: categories)
        self.operational = operational
    }
}

extension FilterNumbersViewModel {

    enum Input {
        case selectedNumberCategory(Category)
    }

    struct State {
        let categories: [Category]
    }
}

 extension FilterNumbersViewModel {

    func trigger(_ input: Input) {
        switch input {

        case .selectedNumberCategory(let category):
            operational.output.send(.validFilter(category.tag))
        }
    }
}

 struct Category: Hashable {
    let id = UUID()
    let description: String
    let tag: String

    static var categories: [Self] {
        [Category(description: "Prime numbers", tag: "prime"),
         Category(description: "Odd numbers", tag: "odd"),
         Category(description: "Even numbers", tag: "even"),
         Category(description: "Negative numbers", tag: "negative")
        ]
    }
}

