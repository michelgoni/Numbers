//
//  File.swift
//  
//
//  Created by Michel Goñi on 6/2/23.
//

import Inject
import SwiftUI

struct NumberView: View {
    let item: Item
    @ObservedObject private var iO = Inject.observer
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 15) {
                Spacer()
                Text(verbatim: item.subtitle)
                    .font(.system(size: 25, weight: .regular))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .animation(.interpolatingSpring(stiffness: 40, damping: 5))
                Text(item.number)
                    .modifier(
                        NumberModifier()
                    )
                    .frame(width: 150, height: 250)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth:.infinity, maxHeight: UIScreen.main.bounds.height / 1.6, alignment: .center)
        }.enableInjection()
    }
}
