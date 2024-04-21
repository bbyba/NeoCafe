//
//  EditProfileView.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

class EditProfileView: UIView {
    lazy var header = CustomHeaderView()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Buttons.backButton.image, for: .normal)
        return button
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.editing
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .ivoryCustom
        label.textAlignment = .center
        return label
    }()

    lazy var personalInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    lazy var nameTextField = CustomTextField(iconName: Asset.TextField.profileTextField.image, customPlaceholder: S.enterYourName)

    lazy var emailTextField = CustomTextField(iconName: Asset.TextField.at.image, customPlaceholder: S.exampleEmail)

    lazy var saveButton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.save, backgroundColor: .darkBlueCustom)
        button.titleLabel?.font = .poppins(ofSize: 16, weight: .semibold)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
        emailTextField.isUserInteractionEnabled = false
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProfileView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(backButton)
        header.addSubview(headerLabel)
        addSubview(personalInfoStack)
        personalInfoStack.addArrangedSubview(nameTextField)
        personalInfoStack.addArrangedSubview(emailTextField)
        addSubview(saveButton)
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
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(29)
            make.centerX.equalToSuperview()
        }

        personalInfoStack.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(personalInfoStack.snp.bottom).offset(56)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
