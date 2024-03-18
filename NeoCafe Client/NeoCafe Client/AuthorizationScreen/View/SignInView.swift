//
//  SignInView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.07.
//

import UIKit
import SnapKit

class SignInView: UIStackView {
    lazy var emailTextField = CustomTextField(iconName: Asset.TextField.at.image, customPlaceholder: S.enterEmail)

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    func addSubviews() {
        addArrangedSubview(emailTextField)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
