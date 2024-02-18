//
//  RegisterVC.swift
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
        baseAuthRegView.getCodebutton.addTarget(self, action: #selector(getCodeButtonPressed), for: .touchUpInside)
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let newState: ViewState = sender.selectedSegmentIndex == 0 ? .signIn : .registration
        viewModel.changeViewState(to: newState)
        baseAuthRegView.updateViewForSegmentIndex(index: newState == .signIn ? 0 : 1)
    }

    @objc private func getCodeButtonPressed() {
        emailValidation()
        if !viewModel.emailValidationFailed {
            switchToCodeConfirmation()
        }
    }

    func emailValidation() {
        let email: String
        switch viewModel.currentState {
        case .signIn:
            email = baseAuthRegView.signInView.emailTextField.text ?? ""
        case .registration:
            email = baseAuthRegView.registrationView.emailTextFieldReg.text ?? ""
        default:
            return
        }

        viewModel.validateEmail(email: email)
//        print("Email validation result: \(viewModel.emailValidationFailed)")
        baseAuthRegView.wrongEmailErrorLabel.isHidden = !viewModel.emailValidationFailed
    }

    func switchToCodeConfirmation() {
        viewModel.changeViewState(to: .codeConfirmation)
        baseAuthRegView.showCodeConfirmationView()
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct RegisterVCPreview: PreviewProvider {
    static var previews: some View {
        RegistrationViewController().showPreview()
    }
}
#endif
