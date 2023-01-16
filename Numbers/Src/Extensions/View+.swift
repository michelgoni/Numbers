//
//  View+.swift
//  Numbers
//
//  Created by Michel Goñi on 4/1/23.
//

import SwiftUI

extension View {

    func initializeAlert(_ alertManager: AlertView) -> some View {
       self.modifier(AlertViewModifier(alert: alertManager))
   }

    func onAppearOnce(_ action: @escaping () -> ()) -> some View {
        modifier(OnAppearOnce(action: action))
    }

    func show(_ condition: Bool) -> some View {
        modifier(ShowModifier(active: condition))
    }


    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }


}

struct ShowModifier: ViewModifier {
    var active: Bool

    func body(content: Content) -> some View {
        if active {
            content
        }
    }
}
