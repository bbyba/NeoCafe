//
//  CustomSegmentedControl.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.03.
//

import Foundation
import UIKit

class CustomSegmentedControl: UISegmentedControl {
    private var segmentInset: CGFloat = 0.1 {
        didSet {
            if segmentInset == 0 {
                segmentInset = 0.1
            }
        }
    }

    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = Asset.Colors.grey.color
        layer.cornerRadius = 25
        layer.masksToBounds = true
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: FontFamily.Poppins.bold.font(size: 15),
            .foregroundColor: Asset.Colors.darkBlue.color
        ]
        setTitleTextAttributes(fontAttributes, for: .normal)
        setTitleTextAttributes([.foregroundColor: Asset.Colors.white.color], for: .selected)


        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.backgroundColor = Asset.Colors.orange.color
            selectedImageView.image = nil
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = 25
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
