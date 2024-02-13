//
//  CustomButton.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        layer.cornerRadius = 18
        titleLabel?.font = FontFamily.Poppins.bold.font(size: 16)
    }

    func setProperties(title: String, backgroundColor: UIColor) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
