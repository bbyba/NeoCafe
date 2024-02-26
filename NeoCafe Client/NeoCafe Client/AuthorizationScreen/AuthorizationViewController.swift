//
//  RegistrationViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI

class RegistrationViewController: UIViewController {
    private lazy var baseAuthRegView = BaseAuthRegView()
    private var viewModel = AuthViewModel()

    override func loadView() {
        view = baseAuthRegView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        baseAuthRegView.getCodebutton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let newState: ViewState = sender.selectedSegmentIndex == 0 ? .signIn : .registration
        viewModel.changeViewState(to: newState)
        baseAuthRegView.updateViewForSegmentIndex(index: newState == .signIn ? 0 : 1)
    }

    @objc private func getCodeButtonTapped() {
        switch self.viewModel.currentState {
        case .codeConfirmation:
            print("current viewstate: \(self.viewModel.currentState)")
            registerLoginUserRequest()
        default:
            print("current viewstate: \(self.viewModel.currentState)")
            requestCodeButton()
        }
    }

    private func getEmailString() -> String? {
        if viewModel.currentState == .codeConfirmation, let previousState = viewModel.previousState {
            switch previousState {
            case .signIn:
                return baseAuthRegView.signInView.emailTextField.text
            case .registration:
                return baseAuthRegView.registrationView.emailTextFieldReg.text
            default:
                return nil
            }
        } else {
            switch viewModel.currentState {
            case .signIn:
                return baseAuthRegView.signInView.emailTextField.text
            case .registration:
                return baseAuthRegView.registrationView.emailTextFieldReg.text
            case .codeConfirmation:
                return nil
            }
        }
    }


    private func getCodeString() -> String? {
        baseAuthRegView.codeConfirmationView.otpField.getPin()
    }

    func emailValidation(email: String?) {
        guard let email = email else { return }
        viewModel.validateEmail(email: email)
        baseAuthRegView.wrongEmailErrorLabel.isHidden = !viewModel.emailValidationFailed
    }

    private func requestConfirmationCode(email: String) {
        if !viewModel.emailValidationFailed {
            viewModel.requestConfirmationCode(email: email) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.switchToCodeConfirmation()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    private func requestCodeButton() {
        print("getCodeButtonTapped")
        guard let email = getEmailString() else { return }
        emailValidation(email: email)
        requestConfirmationCode(email: email)
    }

    private func registerLoginUserRequest() {
        guard let email = getEmailString(), let code = getCodeString() else { return }
        print("confirm button tapped")
        print("\(email) and  \(code)")

        viewModel.registerLoginUser(email: email, confirmationCode: code) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Success: registerLoginUser")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }


    func switchToCodeConfirmation() {
        viewModel.changeViewState(to: .codeConfirmation)
        baseAuthRegView.showCodeConfirmationView()
    }
}

//#if DEBUG
//
//@available(iOS 13.0, *)
//struct RegisterVCPreview: PreviewProvider {
//    static var previews: some View {
//        RegistrationViewController().showPreview()
//    }
//}
//#endif
