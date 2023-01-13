//
//  TitleModifier.swift
//  Numbers
//
//  Created by Michel Goñi on 29/12/22.
//

import SwiftUI

private extension String {
    static let listNumber = "list.number"
}

struct TitleModifier: ViewModifier {
    let title: String
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: .listNumber)
                        Text(title)
                            .font(.headline)
                    }
                }
            }
    }
}
