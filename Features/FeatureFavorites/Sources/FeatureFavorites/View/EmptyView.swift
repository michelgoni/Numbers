//
//  EmptyView.swift
//  Numbers
//
//  Created by Michel Goñi on 4/1/23.
//

import Inject
import SwiftUI

private extension String {
    static let listNumber = "list.number"
    static let title = "Add some some numbers to give it a try"
}

struct EmptyView: View {
    @ObservedObject private var iO = Inject.observer
    var body: some View {

        VStack {
            Image(systemName: .listNumber)
                .imageScale(.large)
            Text(verbatim: .title)
                .font(.headline)
                .padding()
            Image(systemName: .listNumber)
                .imageScale(.large)
        }.enableInjection()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
