//
//  ErrorView.swift
//  
//
//  Created by Michel Goñi on 29/5/23.
//

import SwiftUI

private extension String {
    static let bug = "ant.circle.fill"
    
}

struct ErrorView: View {
    let errortext: String
    var body: some View {

        VStack {
            Image(systemName: .bug)
                .imageScale(.large)
            Text(verbatim: errortext)
                .font(.headline)
                .padding()
            Image(systemName: .bug)
                .imageScale(.large)
        }
    }
}

struct ErrorViewPreviews: PreviewProvider {
    static var previews: some View {
        ErrorView(errortext: "There seems to be an error")
    }
}
