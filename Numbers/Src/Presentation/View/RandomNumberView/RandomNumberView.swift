//
//  RandomNumberView.swift
//  Numbers
//
//  Created by Michel Goñi on 15/1/23.
//

import SwiftUI

struct RandomNumberView: View {
    @State var progressValue: Float = 0.0

    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)

            VStack {
                RandomNumberProgressView(progress: self.$progressValue)
                    .frame(width: 150.0, height: 150.0)
                    .padding(60.0)

                Spacer()
            }
        }
    }
}
struct RandomNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
