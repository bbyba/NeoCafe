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
    lazy var wrongEmailErrorLabel: UILabel = {
        let label = UILabel()
        label.text = S.wrongEmail
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = FontFamily.Poppins.medium.font(size: 16)
        label.textColor = Asset.Colors.coral.color
        label.isHidden = true
        return label
    }()

    lazy var emailTextFieldReg = CustomTextField(iconName: Asset.TextField.at.image, customPlaceholder: S.exampleEmail)

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    func addSubviews() {
        addArrangedSubview(wrongEmailErrorLabel)
        addArrangedSubview(emailTextFieldReg)
    }

    // to move to model
//    func validateEmail() {
//        guard let email = emailTextFieldReg.text else { return }
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//        let isValidEmail = emailTest.evaluate(with: email)
//
//        emailTextFieldReg.layer.borderColor = isValidEmail ? UIColor.black.cgColor : UIColor.red.cgColor
//        emailTextFieldReg.layer.borderWidth = isValidEmail ? 0 : 1
//
//        wrongEmailErrorLabel.isHidden = isValidEmail
//        wrongEmailErrorLabel.textColor = isValidEmail ? .clear : .red
//    }

    func validateEmail() -> Bool {
        guard let email = emailTextFieldReg.text, !email.isEmpty else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
