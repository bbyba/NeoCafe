//
//  RegisterVC.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.02.
//

import UIKit

class RegisterVC: UIViewController {
    lazy var baseAuthRegView = BaseAuthRegView()
    lazy var registrationView = RegistrationView()
    lazy var signinView = SignInView()
    lazy var codeConfirmationView = CodeConfirmationView()

    override func loadView() {
        view = baseAuthRegView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewForSegmentIndex(index: baseAuthRegView.segmentedControl.selectedSegmentIndex)
        addTargets()
    }

    private func addTargets() {
        baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        baseAuthRegView.getCodebutton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
    }

    private func configureInitialView() {
        let selectedIndex = baseAuthRegView.segmentedControl.selectedSegmentIndex
        updateViewForSegmentIndex(index: selectedIndex)
    }

    private func updateViewForSegmentIndex(index: Int) {
        baseAuthRegView.textFieldStackView.subviews.forEach { $0.removeFromSuperview() }
        let viewToAdd: UIView = index == 0 ? signinView : registrationView
        baseAuthRegView.textFieldStackView.addSubview(viewToAdd)
        viewToAdd.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        updateButtonText(forIndex: index)
    }

    private func updateButtonText(forIndex index: Int) {
        let buttonTitle = index == 0 ? S.getCode : S.register
        baseAuthRegView.getCodebutton.setTitle(buttonTitle, for: .normal)
    }

    private func goToCodeConfirmation() {
        baseAuthRegView.textFieldStackView.subviews.forEach { $0.removeFromSuperview() }
        baseAuthRegView.textFieldStackView.addSubview(codeConfirmationView)
        codeConfirmationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        baseAuthRegView.getCodebutton.setTitle(S.confirm, for: .normal)
    }

    @objc func segmentedControlValueChanged() {
        let selectedIndex = baseAuthRegView.segmentedControl.selectedSegmentIndex
        updateViewForSegmentIndex(index: selectedIndex)
    }

    @objc func getCodeButtonTapped() {
        if signinView.validateEmail() {
            let selectedIndex = baseAuthRegView.segmentedControl.selectedSegmentIndex
            if selectedIndex == 0 {
                goToCodeConfirmation()
                //                getVerificationCode()
            } else {
                goToCodeConfirmation()
                //                registerAccount()
            }
        }
    }
}
