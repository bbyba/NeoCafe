//
//  CustomTextField.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.04.
//

import UIKit

class CustomTextField: UITextField {
    var iconName: UIImage?
    var customPlaceholder: String?

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()

    init(iconName: UIImage?, customPlaceholder: String) {
        self.iconName = iconName
        self.customPlaceholder = customPlaceholder
        super.init(frame: .zero)
        setupTextField()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let leftView = leftView {
            leftView.frame = CGRect(x: 0, y: 0, width: 40, height: bounds.height)
            iconImageView.frame = CGRect(x: 10, y: 0, width: 20, height: bounds.height)
        }
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }

    private func setupTextField() {
        autocapitalizationType = .none
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        backgroundColor = .greyCustom
        textColor = .darkBlueCustom
        font = .sFProDisplayFont(ofSize: 16)
        attributedPlaceholder = NSAttributedString(string: customPlaceholder ?? "", attributes: [NSAttributedString.Key.font: font])
        layer.cornerRadius = 18
        iconImageView.isHidden = iconName == nil
        iconImageView.image = iconName

        if let iconName = iconName {
            let leftViewContainer = UIView()
            leftViewContainer.addSubview(iconImageView)
            leftView = leftViewContainer
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }
}
