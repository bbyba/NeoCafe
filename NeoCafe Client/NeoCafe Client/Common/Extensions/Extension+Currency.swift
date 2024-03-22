//
//  Extension+Currency.swift
//  NeoCafe Client
//

import UIKit

extension Double {
    func toCurrencyString(currencyCode: String = "KGS") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
