//
//  AlertViewModfier.swift
//  Numbers
//
//  Created by Michel Goñi on 3/1/23.
//

import SwiftUI

struct AlertViewModifier: ViewModifier {

    @ObservedObject var alert: AlertView

        func body(content: Content) -> some View {
           content.alert(isPresented: $alert.showAlertView) {
               alert.getSystemAlert
           }
       }
}
