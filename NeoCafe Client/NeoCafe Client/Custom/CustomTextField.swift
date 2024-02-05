//
//  CustomTextField.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.04.
//

import UIKit

class CustomTextField: UITextField {
    var iconName: String
    var customPlaceholder: String
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()
    
    init(iconName: String, customPlaceholder: String) {
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
        self.backgroundColor = K.ConstantColors.grey
        self.textColor = K.ConstantColors.black
        let font = UIFont.systemFont(ofSize: 16)//change later
        self.font = font
        self.attributedPlaceholder = NSAttributedString(string: customPlaceholder, attributes: [NSAttributedString.Key.font: font])
        self.layer.cornerRadius = 18
        
        iconImageView.image = UIImage(named: iconName)
        let leftViewContainer = UIView()
        leftViewContainer.addSubview(iconImageView)
        self.leftView = leftViewContainer
        self.leftViewMode = .always
    }
}
