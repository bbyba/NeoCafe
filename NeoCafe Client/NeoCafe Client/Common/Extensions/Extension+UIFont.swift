//
//  Extension+UIFont.swift
//  NeoCafe Client
//

import UIKit

extension UIFont {
    public static func poppins(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
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

    public static func sFProDisplayFont(ofSize size: CGFloat) -> UIFont {
        return FontFamily.SFProDisplay.regular.font(size: size)
    }
}
