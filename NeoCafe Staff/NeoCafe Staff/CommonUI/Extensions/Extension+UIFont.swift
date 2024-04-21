//
//  Extension+UIFont.swift
//  NeoCafe Staff
//

import UIKit

public extension UIFont {
    static func poppins(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .bold:
            return FontFamily.Poppins.bold.font(size: size)
        case .medium:
            return FontFamily.Poppins.medium.font(size: size)
        case .regular:
            return FontFamily.Poppins.regular.font(size: size)
        case .semibold:
            return FontFamily.Poppins.semiBold.font(size: size)
        default:
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }

    static func sFProDisplayFont(ofSize size: CGFloat) -> UIFont {
        return FontFamily.SFProDisplay.regular.font(size: size)
    }
}
