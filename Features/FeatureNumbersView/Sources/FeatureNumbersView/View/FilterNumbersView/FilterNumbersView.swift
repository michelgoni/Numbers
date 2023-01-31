//
//  FilterNumbersView.swift
//  
//
//  Created by Michel Goñi on 31/1/23.
//

import Combine
import SwiftUI
import NumbersEx

 struct FilterNumbersView: View {

     typealias ViewModel = AnyViewModel<FilterNumbersViewModel.Input, FilterNumbersViewModel.State>
    @ObservedObject  var viewModel: ViewModel

     init(viewModel: ViewModel) {

        self.viewModel = viewModel
    }
     var body: some View {
        HStack(spacing: 12.0) {
            ForEach(Category.categories, id: \.id) { category in
                Text(category.description)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 8.0)
                    .padding(.horizontal, 8.0)
                    .background(Color.white, in: Capsule())
                    .shadowNormal(color: Color.gray.opacity(0.5))
                    .eraseToButton { [weak viewModel] in
                        viewModel?.trigger(.selectedNumberCategory(category))
                    }
            }
        }
        .padding(16)
        .padding(.bottom, 4.0)
        .scrollable(.horizontal, showIndicators: false)
    }
}

@available(iOS 13.0, *)
public struct SearchOperational: OperationalFlow {
    public let input: Void = ()
    public var output = Output()

    public init() {}

}

@available(iOS 13.0, *)
public extension SearchOperational {

    enum Element {
        case invalidFilter
        case validFilter(String)
    }
}
