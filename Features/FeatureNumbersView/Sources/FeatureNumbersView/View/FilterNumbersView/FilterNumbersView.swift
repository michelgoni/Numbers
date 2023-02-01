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
    @State private var categorySelected: String?
    private let categories: [Category]

    init(viewModel: ViewModel, categories: [Category]) {
        self.categories = categories
        self.viewModel = viewModel
    }

     var body: some View {
        HStack(spacing: 12.0) {
            ForEach(categories, id: \.id) { category in
                Text(category.description)
                    .font(.subheadline)
                    .foregroundColor(categorySelected == category.tag ? Color.white : Color.gray)
                    .padding(.vertical, 8.0)
                    .padding(.horizontal, 8.0)
                    .background(categorySelected == category.tag ? Color.black : Color.white, in: Capsule())
                    .shadowNormal(color: Color.gray.opacity(0.5))
                    .eraseToButton { [weak viewModel] in
                        categorySelected =  categorySelected == category.tag ? nil : category.tag
                        categorySelected == nil ? viewModel?.trigger(.selectedNumberCategory(nil)) : viewModel?.trigger(.selectedNumberCategory(category))
                    }
            }
        }
        .padding(16)
        .padding(.bottom, 4.0)
        .scrollable(.horizontal, showIndicators: false)
    }

}

public struct SearchOperational: OperationalFlow {
    public let input: Void = ()
    public var output = Output()

    public init() {}

}

public extension SearchOperational {

    enum Element {
        case invalidFilter
        case validFilter(String?)
    }
}
