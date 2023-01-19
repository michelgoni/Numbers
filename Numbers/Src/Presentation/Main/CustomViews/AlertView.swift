//
//  AlertView.swift
//  Numbers
//
//  Created by Michel Goñi on 3/1/23.
//

import Foundation
import SwiftUI

//private extension String {
//    static let errorTitle = "Error"
//}
//
//enum AlertAction {
//    case ok
//    case cancel
//    case others
//}
//
//class AlertView: ObservableObject {
//    typealias closure = () -> ()
//
//    @Published public var showAlertView = false
//    private var title = ""
//    private var message = ""
//    private var okCompletion: (buttonName: String, closure: (closure)) = ("", {})
//
//    func showAlertView(title: String = .errorTitle,
//                       message: String,
//                       okCompletion: (buttonName: String, closure: (closure))) {
//        self.title = title
//        self.message = message
//        self.okCompletion = okCompletion
//        self.showAlertView = true
//    }
//
//    var getSystemAlert: Alert {
//
//        let primaryButton = Alert.Button.default(Text(okCompletion.buttonName)) {
//            self.okCompletion.closure()
//        }
//        return Alert(title: Text(title),
//                     message: Text(message),
//                     dismissButton: primaryButton)
//    }
//}

