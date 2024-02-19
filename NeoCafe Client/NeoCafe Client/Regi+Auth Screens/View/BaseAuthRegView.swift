//
//  BaseAuthRegView.swift
//  NeoCafe Client
//

import Foundation
import UIKit
import SnapKit

class BaseAuthRegView: UIView {
    lazy var registrationView = RegistrationView()
    lazy var signInView = SignInView()
    lazy var codeConfirmationView = CodeConfirmationView()
    
    lazy var headerSection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .blueCustom
        return view
    }()

    lazy var headerImage: UIImageView = {
        let imageView = UIImageView(image: Asset.Splash.twoBeans.image)
        return imageView
    }()

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
        button.setProperties(title: S.getCode, backgroundColor: Asset.Colors.darkBlue.color)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteCustom
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(headerSection)
        addSubview(headerImage)
        headerSection.addSubview(headerLabel)
        addSubview(segmentedControl)
        addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(wrongEmailErrorLabel)
        textFieldStackView.addArrangedSubview(signInView)
        addSubview(getCodebutton)
    }

    func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }

        headerImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(headerSection)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.trailing.equalToSuperview()
        }

        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(38)
        }

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerSection.snp.bottom).inset(segmentedControl.frame.height / 2)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.leading.trailing.equalToSuperview().inset(16)
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
        default:
            textFieldStackView.addArrangedSubview(signInView)
            headerLabel.text = S.entry
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
