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
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    func addSubviews() {
        addArrangedSubview(emailTextField)
    }

//    func resetView() {
//        emailTextField.text = ""
//    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
