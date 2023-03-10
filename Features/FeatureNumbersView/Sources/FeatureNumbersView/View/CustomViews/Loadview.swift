//
//  File.swift
//  
//
//  Created by Michel Goñi on 20/1/23.
//

import SwiftUI

private extension CGFloat {
    static let scaleSize = 1.0
}

struct LoaderView: View {

    var body: some View {
        ProgressView()
            .scaleEffect(.scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
    }
}
