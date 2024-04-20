//
//  CustomRoundButton.swift
//  NeoCafe Client
//
import UIKit

class CustomRoundButton: UIButton {

    init(withImage image: UIImage?, backgroundColor: UIColor, iconTint: UIColor?) {
        super.init(frame: .zero)
        configureButton(image: image, backgroundColor: backgroundColor, iconTint: iconTint)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        clipsToBounds = true
    }

    func configureButton(image: UIImage?, backgroundColor: UIColor, iconTint: UIColor?) {
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        if let iconTint = iconTint {
            // Change the tint color of the button's image view
            imageView?.tintColor = iconTint
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
