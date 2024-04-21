//
//  CustomSegmentedControl.swift
//  NeoCafe Staff
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
        backgroundColor = .greyCustom
        layer.cornerRadius = 25
        layer.masksToBounds = true
        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppins(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.darkBlueCustom,
        ]
        setTitleTextAttributes(fontAttributes, for: .normal)
        setTitleTextAttributes([.foregroundColor: Asset.Colors.white.color], for: .selected)

        let selectedImageViewIndex = numberOfSegments
        if let selectedImageView = subviews[selectedImageViewIndex] as? UIImageView {
            selectedImageView.backgroundColor = .orangeCustom
            selectedImageView.image = nil
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = 25
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
        }
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
