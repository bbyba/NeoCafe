//
//  CodeConfirmationView.swift
//  NeoCafe Client
//

import SnapKit
import SVPinView
import Foundation

class CodeConfirmationView: UIStackView {
    lazy var enterCodeMessageLabel: UILabel = {
        let label = UILabel()
        label.text = S.otpCodeLabel
        label.textColor = Asset.Colors.darkBlue.color
        label.font = FontFamily.Poppins.regular.font(size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var otpField: SVPinView = {
        let pinView = SVPinView()
        pinView.pinLength = 4
        pinView.interSpace = 8
        pinView.textColor = Asset.Colors.darkBlue.color
        pinView.font = FontFamily.Poppins.regular.font(size: 20)
        pinView.shouldSecureText = false
        pinView.fieldBackgroundColor = Asset.Colors.grey.color
        pinView.fieldCornerRadius = 15
        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
        pinView.keyboardType = .numberPad
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

//        func setupConstraints() {
//            otpField.snp.makeConstraints { make in
//                make.top.equalToSuperview()
//                make.height.equalTo(52)
//            }
//        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
