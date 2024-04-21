//
//  CustomRoundButton.swift
//  NeoCafe Staff
//
import UIKit

class CustomRoundButton: UIButton {
    init(withImage image: UIImage?, backgroundColor: UIColor) {
        super.init(frame: .zero)
        configureButton(image: image, backgroundColor: backgroundColor)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        clipsToBounds = true
    }

    func configureButton(image: UIImage?, backgroundColor: UIColor) {
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
