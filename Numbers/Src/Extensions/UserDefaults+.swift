//
//  UserDefaults+.swift
//  Numbers
//
//  Created by Michel Goñi on 10/1/23.
//

import Foundation

extension UserDefaults {
    @objc dynamic var status: [Data] {
        get { value(forKey: "") as? [Data] ?? [Data()] }
        set { setValue(newValue, forKey: "") }
    }
}

