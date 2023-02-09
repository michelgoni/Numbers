//
//  MainView.swift
//  Numbers
//
//  Created by Michel Goñi on 2/2/23.
//

import NumbersEx
import SwiftUI

private extension String {
    static let numbersImage = "list.number"
    static let favsImage = "number"
    static let infinite = "infinity"
}

struct MainView: View {

    var body: some View {
        Container()
    }
}

private struct Container: View {

    @Environment(\.viewFactory) private var viewFactory
    @State private var selectedTab: Int = TagType.infinite.rawValue
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                viewFactory.getInfiniteScroll().tabItem(.infinite)
                viewFactory.getNumbersMainView().tabItem(.numbers)
                viewFactory.getNumbersFavoritesView().tabItem(.favorites)
            }
        }
    }
}

enum TagType: Int {
    case infinite
    case numbers
    case favorites
}

private extension TagType {
    var title: String {
        switch self {
        case .numbers:
            return "Numbers"
        case .favorites:
            return "Favorites"
        case .infinite:
            return "Scroll"
        }
    }

    var image: Image {
        switch self {
        case .numbers:
            return Image(systemName: .numbersImage)
        case .favorites:
            return Image(systemName: .favsImage)
        case .infinite:
            return Image(systemName: .infinite)

        }
    }
}

private extension View {

    func tabItem(_ tab: TagType) -> some View {
        eraseToTabItem(tab.title,
                       image: tab.image,
                       tag: tab.rawValue)
    }
}
