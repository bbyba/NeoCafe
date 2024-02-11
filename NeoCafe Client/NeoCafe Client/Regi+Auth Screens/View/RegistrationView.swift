//
//  RegistrationView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.07.
//

import UIKit
import Foundation
import SnapKit

class RegistrationView: UIStackView {
    lazy var emailTextField = CustomTextField(iconName: "at", customPlaceholder: "Введите почту")

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        axis = .vertical
        spacing = 14
    }

        func addSubviews() {
        addArrangedSubview(emailTextField)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
