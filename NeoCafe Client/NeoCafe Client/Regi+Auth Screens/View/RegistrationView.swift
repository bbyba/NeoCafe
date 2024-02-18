//
//  RegistrationView.swift
//  NeoCafe Client
//

import UIKit
import SnapKit

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

//    func resetView() {
//        emailTextField.text = ""
//    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
