//
//  BaseAuthRegView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class BaseAuthRegView: UIView, BaseContentView {
    lazy var registrationView = RegistrationView()
    lazy var signInView = SignInView()
    lazy var codeConfirmationView = CodeConfirmationView()

    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.entry
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        return label
    }()

    lazy var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: [S.enter, S.registration])
        segmentedControl.contentMode = .scaleToFill
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

//    lazy var textFieldStackView = UIStackView()
    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        return stackView
    }()

    lazy var getCodebutton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.getCode, backgroundColor: .darkBlueCustom)
        return button
    }()

    lazy var wrongEmailErrorLabel: UILabel = {
        let label = UILabel()
        label.text = S.wrongEmail
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .poppins(ofSize: 16, weight: .medium)
        label.textColor = .coralCustom
        label.isHidden = true
        return label
    }()

//    lazy var resendButton: UIButton = {
//        let button = UIButton()
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: UIFont.poppins(ofSize: 16, weight: .semibold),
//            .foregroundColor: UIColor.orangeCustom,
//            .underlineStyle: NSUnderlineStyle.single.rawValue
//        ]
//        let attributedTitle = NSAttributedString(string: S.resend, attributes: attributes)
//        button.setAttributedTitle(attributedTitle, for: .normal)
//        return button
//    }()

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
        label.font =  .poppins(ofSize: 14, weight: .bold)
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
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        addSubview(segmentedControl)
        addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(wrongEmailErrorLabel)
        textFieldStackView.addArrangedSubview(signInView)
        addSubview(getCodebutton)
        addSubview(resendButtonStack)
        resendButtonStack.addArrangedSubview(resendButton)
        resendButtonStack.addArrangedSubview(timeCounter)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(51)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
        }

        segmentedControl.snp.makeConstraints { make in
            make.centerY.equalTo(header.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        getCodebutton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        resendButtonStack.snp.makeConstraints { make in
            make.top.equalTo(getCodebutton.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-5)
        }

        resendButtonStack.isHidden = true
    }

    // MARK: - Switch between registration and authorization

    func updateViewForSegmentIndex(index: Int) {
        let currentViews = textFieldStackView.arrangedSubviews
        currentViews.forEach { view in
            if view !== wrongEmailErrorLabel {
                textFieldStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }

        switch index {
        case 1:
            textFieldStackView.addArrangedSubview(registrationView)
            headerLabel.text = S.registration
            resendButtonStack.isHidden = true
        default:
            textFieldStackView.addArrangedSubview(signInView)
            headerLabel.text = S.entry
            resendButtonStack.isHidden = true
        }

        textFieldStackView.insertArrangedSubview(wrongEmailErrorLabel, at: 0)
    }

    func showCodeConfirmationView() {
        getCodebutton.setTitle(S.confirm, for: .normal)
        textFieldStackView.arrangedSubviews.forEach {
            textFieldStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        textFieldStackView.addArrangedSubview(codeConfirmationView)
        headerLabel.text = S.verificationCode
        resendButtonStack.isHidden = false
    }

    func updateResendButtonAttributedTitle() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppins(ofSize: 16, weight: .semibold),
            .foregroundColor: UIColor.orangeCustom,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedTitle = NSAttributedString(string: S.resend, attributes: attributes)
        resendButton.setAttributedTitle(attributedTitle, for: .normal)
    }

    func resetResendButton() {
        resendButton.setTitle(S.resend, for: .normal)
        resendButton.setTitleColor(UIColor.darkGreyCustom, for: .normal)
        resendButton.isEnabled = true
        timeCounter.isHidden = true
        timeCounter.text = ""

        // Remove attributed title if it was set during error state
//        baseAuthRegView.resendButton.setAttributedTitle(nil, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
