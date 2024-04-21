//
// CodeConfirmationView.swift
// NeoCafe Staff
//

import SnapKit
import SVPinView
import UIKit

class CodeConfirmationView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.verificationCode
        label.font = .poppins(ofSize: 24, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var enterCodeMessageLabel: UILabel = {
        let label = UILabel()
        label.text = S.otpCodeLabel
        label.textColor = .darkBlueCustom
        label.font = .poppins(ofSize: 16, weight: .medium)
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
        pinView.keyboardType = .numberPad
        pinView.shouldSecureText = false
        pinView.fieldBackgroundColor = .greyCustom
        pinView.style = .underline
        pinView.deleteButtonAction = .deleteCurrent
        pinView.pinInputAccessoryView = UIView()
        return pinView
    }()

    lazy var backButton = CustomRoundButton(withImage: Asset.Images.arrowBack.image, backgroundColor: .lightBlueCustom)

    lazy var confirmButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.confirm, backgroundColor: .lightBlueCustom)
        return button
    }()

    lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle(S.resendAfter, for: .normal)
        button.setTitleColor(.darkGreyCustom, for: .normal)
        button.titleLabel?.font = .poppins(ofSize: 16, weight: .semibold)
        return button
    }()

    lazy var timeCounter = {
        let label = UILabel()
        label.text = ""
        label.font = .poppins(ofSize: 14, weight: .bold)
        label.textColor = .darkGreyCustom
        return label
    }()

    lazy var resendButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    func resetResendButton() {
        resendButton.setTitle(S.resend, for: .normal)
        resendButton.setTitleColor(UIColor.darkGreyCustom, for: .normal)
        resendButton.isEnabled = true
        timeCounter.isHidden = true
        timeCounter.text = ""
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CodeConfirmationView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(enterCodeMessageLabel)
        addSubview(otpField)
        addSubview(confirmButton)
        addSubview(resendButtonStack)
        resendButtonStack.addArrangedSubview(resendButton)
        resendButtonStack.addArrangedSubview(timeCounter)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        enterCodeMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        otpField.snp.makeConstraints { make in
            make.top.equalTo(enterCodeMessageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(otpField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        resendButtonStack.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-5)
        }

        resendButtonStack.isHidden = true
    }
}
