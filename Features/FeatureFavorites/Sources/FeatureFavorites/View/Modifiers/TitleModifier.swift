//
//  TitleModifier.swift
//  
//
//  Created by Michel Goñi on 24/1/23.
//

import SwiftUI

private extension String {
    static let listNumber = "list.number"
}

struct TitleModifier: ViewModifier {
    let title: String
    public func body(content: Content) -> some View {
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
