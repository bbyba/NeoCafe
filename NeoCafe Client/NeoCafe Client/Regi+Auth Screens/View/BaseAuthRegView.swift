//
//  RegisterView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.02.
//
import Foundation
import UIKit
import SnapKit

class BaseAuthRegView: UIView {
    lazy var headerSection: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = K.ConstantColors.second
        return view
    }()

    lazy var headerImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "twoBeans"))
        return image
    }()

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 32)
        label.textColor = K.ConstantColors.fourth
        return label
    }()

    lazy var segmentedControl: CustomSegmentedControl = {
        let segmentedControl = CustomSegmentedControl(items: ["Войти", "Регистрация"])
        segmentedControl.contentMode = .scaleToFill
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    lazy var textFieldStackView: UIView = {
        let stack = UIView()
        return stack
    }()

    lazy var button: CustomButton = {
        let button = CustomButton()
        button.setProperties(title: "Получить код", backgroundColor: K.ConstantColors.black)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(headerSection)
        addSubview(headerImage)
        headerSection.addSubview(headerLabel)
        addSubview(segmentedControl)
        addSubview(textFieldStackView)
        addSubview(button)
    }

    func setupConstraints() {
        headerSection.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
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
            make.height.equalTo(80)
            make.width.equalTo(80)
        }

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(headerSection.snp.bottom).inset(segmentedControl.frame.height / 2)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(346)
        }

        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(346)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldStackView.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(346)
            make.height.equalTo(48)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
