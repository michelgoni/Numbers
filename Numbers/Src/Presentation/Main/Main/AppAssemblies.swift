//
//  AppAssemblies.swift
//  Numbers
//
//  Created by Michel Goñi on 23/1/23.
//

import Swinject
import FeatureNumbersView
import FeatureFavorites

var assemblies: [Assembly] {
    [
        FeatureNumbersAssembly(),
        FeatureFavoritesAssembly()
    ]
}

