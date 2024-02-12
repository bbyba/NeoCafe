//
//  CodeConfirmationView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.07.
//

import UIKit
import SVPinView
import Foundation

class CodeConfirmationView: UIStackView {
    lazy var enterCodeMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "enter"
        label.textColor = Assets.ConstantColors.black
        label.numberOfLines = 0
//        label.font = ConstantFont.sfRegular().getUIFont(size: 16)
        label.textAlignment = .center
        return label
    }()

    lazy var otpField: SVPinView = {
        let pinView = SVPinView()
        pinView.pinLength = 4
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.black
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.fieldBackgroundColor = Assets.ConstantColors.grey
        pinView.activeFieldBackgroundColor = Assets.ConstantColors.grey
        pinView.fieldCornerRadius = 18
        pinView.activeFieldCornerRadius = 18
        pinView.placeholder = ""
        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
        pinView.keyboardAppearance = .default
        pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        return pinView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        spacing = 14
        addSubviews()
    }

    private func addSubviews() {
        addArrangedSubview(enterCodeMessageLabel)
        addArrangedSubview(otpField)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
