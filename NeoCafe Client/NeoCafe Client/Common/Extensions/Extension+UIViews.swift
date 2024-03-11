//
//  Extension+UIViews.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.03.09.
//

import Foundation

func configure<T>(_ value: T, using closure: (inout T) throws -> Void) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
