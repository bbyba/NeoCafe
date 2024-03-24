//
//  CustomButton.swift
//  NeoCafe Staff
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 18
        titleLabel?.font = .poppins(ofSize: 16, weight: .bold)
        layer.borderWidth = 2
    }

    func setProperties(title: String, backgroundColor: UIColor, titleColor: UIColor = .whiteCustom, showBorder: Bool = false) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)

        if showBorder {
            layer.borderWidth = 2
            layer.borderColor = titleColor.cgColor
        } else {
            layer.borderWidth = 0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
