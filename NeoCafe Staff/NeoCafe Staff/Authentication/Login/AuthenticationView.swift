//
//  AuthenticationView.swift
//  NeoCafe Staff
//

import UIKit
import SnapKit

class AuthenticationView: UIView {
    lazy var header = CustomHeaderView()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = S.entry
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .darkBlueCustom
        return label
    }()

    lazy var loginTextField = CustomTextField(iconName: Asset.Images.person.image,
                                              customPlaceholder: S.enterLogin)

    lazy var passwordTextField = CustomTextField(iconName: Asset.Images.lock.image,
                                                 customPlaceholder: S.enterPassword,
                                                 isPasswordField: true)

    lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    lazy var getCodebutton: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: S.getCode, backgroundColor: .lightBlueCustom)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setProperties()
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthenticationView: BaseContentView {
    func setProperties() {
        backgroundColor = .whiteCustom
    }

    func addSubviews() {
        addSubview(header)
        header.addSubview(headerLabel)
        addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(loginTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        addSubview(getCodebutton)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
            make.height.equalTo(38)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(48)
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

}
