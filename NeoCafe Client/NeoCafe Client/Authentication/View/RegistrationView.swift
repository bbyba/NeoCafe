//
//  RegistrationView.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

class RegistrationView: UIStackView {
    lazy var emailTextFieldReg = CustomTextField(iconName: Asset.TextField.at.image, customPlaceholder: S.exampleEmail)

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    func addSubviews() {
        addArrangedSubview(emailTextFieldReg)
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
