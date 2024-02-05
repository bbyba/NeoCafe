//
//  RegisterView.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.02.
//
import Foundation
import UIKit
import SnapKit

class RegisterView: UIView {
    
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
        label.text = "Vhod"
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
    
    lazy var textFieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 14
        return stack
    }()

    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(iconName: "at", customPlaceholder: "Введите почту")
        return textField
    }()
    
    lazy var nameTextField: CustomTextField = {
        let textField = CustomTextField(iconName: "profile", customPlaceholder: "Иван")
        return textField
    }()
    
    lazy var emailTextFieldReg: CustomTextField = {
        let textField = CustomTextField(iconName: "at", customPlaceholder: "example@email.com")
        return textField
    }()
    
    lazy var birthdayTextfield: CustomTextField = {
        let textField = CustomTextField(iconName: "calendar", customPlaceholder: "01.01.1999")
        return textField
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
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    func addSubviews(){
        addSubview(headerSection)
        addSubview(headerImage)
        headerSection.addSubview(headerLabel)
        addSubview(segmentedControl)
        addSubview(textFieldStack)
        textFieldStack.addArrangedSubview(emailTextField)
        addSubview(button)
    }
    
    func setupConstraints(){
        
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
        
        textFieldStack.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(346)
        }
              
        button.snp.makeConstraints { make in
            make.top.equalTo(textFieldStack.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(346)
            make.height.equalTo(48)
        }
    }
    
    @objc func segmentedControlValueChanged() {
        let allTextFields = [emailTextField, nameTextField, emailTextFieldReg, birthdayTextfield]
        allTextFields.forEach { textFieldStack.removeArrangedSubview($0); $0.removeFromSuperview() }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            // Login
            textFieldStack.addArrangedSubview(emailTextField)
        } else {
            // Registration
            textFieldStack.addArrangedSubview(nameTextField)
            textFieldStack.addArrangedSubview(emailTextFieldReg)
            textFieldStack.addArrangedSubview(birthdayTextfield)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
