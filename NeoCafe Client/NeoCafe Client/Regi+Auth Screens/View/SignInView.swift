//
//  SignInView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.07.
//

import UIKit
import Foundation
import SnapKit

class SignInView: UIStackView {
    lazy var emailTextFieldReg = CustomTextField(iconName: "at", customPlaceholder: "example@email.com")

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    func addSubviews() {
        addArrangedSubview(emailTextFieldReg)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
