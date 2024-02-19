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
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var otpField: SVPinView = {
        let pinView = SVPinView()
        pinView.pinLength = 4
        pinView.interSpace = 8
        pinView.textColor = .darkBlueCustom
        pinView.font = .poppins(ofSize: 20, weight: .regular)
        pinView.shouldSecureText = false
        pinView.fieldBackgroundColor = .greyCustom
//        pinView.fieldCornerRadius = 15
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
