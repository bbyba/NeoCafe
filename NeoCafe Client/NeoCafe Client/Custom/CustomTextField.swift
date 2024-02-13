//
//  CustomTextField.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.04.
//

import UIKit

class CustomTextField: UITextField {
    var iconName: UIImage
    var customPlaceholder: String

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()

    init(iconName: UIImage, customPlaceholder: String) {
        self.iconName = iconName
        self.customPlaceholder = customPlaceholder
        super.init(frame: .zero)
        setupTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let leftView = self.leftView {
            leftView.frame = CGRect(x: 0, y: 0, width: 40, height: bounds.height)
            iconImageView.frame = CGRect(x: 10, y: 0, width: 20, height: bounds.height)
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }

    private func setupTextField() {
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
        self.backgroundColor = Asset.Colors.grey.color
        self.textColor = Asset.Colors.darkBlue.color
//        let font = FontFamily.SFProDisplay.regular.font(size: 16)
        self.font = FontFamily.SFProDisplay.regular.font(size: 16)
        self.attributedPlaceholder = NSAttributedString(string: customPlaceholder, attributes: [NSAttributedString.Key.font: font])
        self.layer.cornerRadius = 18
        iconImageView.image = iconName
        let leftViewContainer = UIView()
        leftViewContainer.addSubview(iconImageView)
        self.leftView = leftViewContainer
        self.leftViewMode = .always
    }
}
