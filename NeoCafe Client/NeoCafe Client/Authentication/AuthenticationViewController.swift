//
//  AuthenticationViewController.swift
//  NeoCafe Client
//

import UIKit
import Moya

class AuthenticationViewController: BaseViewController<AuthViewModel, BaseAuthRegView> {

    var timer: Timer?
    var secondsRemaining = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        contentView.getCodebutton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
        contentView.resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }

    private func getEmailString() -> String? {
        switch viewModel.currentState {
        case .signIn:
            return contentView.signInView.emailTextField.text
        case .registration:
            return contentView.registrationView.emailTextFieldReg.text
        case .codeConfirmation:
            return nil
        }
    }

    private func emailValidation(email: String?) -> Bool {
        guard let email = email else { return false }
        return viewModel.validateEmail(email: email)
    }
    
    private func handleCodeRequest() {
        guard let email = getEmailString() else {
            return
        }
        let isValid = viewModel.validateEmail(email: email)
        contentView.wrongEmailErrorLabel.isHidden = isValid

        if isValid {
            viewModel.storeEmail(email: email)
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
        handleCodeRequest()
    }

    private func getCodeString() -> String? {
        contentView.codeConfirmationView.otpField.getPin()
    }

//    private func authenticateUserRequest() {
//        guard let storedEmail = viewModel.storedEmail, let code = getCodeString() else {
//            print("Email is not stored or code is nil")
//            return
//        }
//
//        print("confirm button tapped")
//        print("\(storedEmail) and \(code)")
//
//        viewModel.authenticateUser(email: storedEmail, confirmationCode: code) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    print("Success: authenticateUser")
//                    self.viewModel.onMainNavigate
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self.baseAuthRegView.updateResendButtonAttributedTitle()
//                }
//            }
//        }
//    }

    private func authenticateUserRequest() {
        guard let storedEmail = viewModel.storedEmail, let code = getCodeString() else {
            print("Email is not stored or code is nil")
            return
        }

        viewModel.authenticateUser(email: storedEmail, confirmationCode: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.viewModel.onMainNavigate?()
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.contentView.updateResendButtonAttributedTitle()
                }
            }
        }
    }

    func switchToCodeConfirmation() {
        viewModel.changeViewState(to: .codeConfirmation)
        contentView.showCodeConfirmationView()
        startTimer()
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let newState: ViewState = sender.selectedSegmentIndex == 0 ? .signIn : .registration
        viewModel.changeViewState(to: newState)
        contentView.updateViewForSegmentIndex(index: newState == .signIn ? 0 : 1)
    }

    @objc private func getCodeButtonTapped() {
        switch self.viewModel.currentState {
        case .codeConfirmation:
            authenticateUserRequest()
        default:
            requestCodeButton()
        }
    }
}

extension AuthenticationViewController {

    // MARK:- Timer logic
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            contentView.timeCounter.text = timeString(time: TimeInterval(secondsRemaining))
            contentView.resendButton.isEnabled = false
        } else {
            timer?.invalidate()
            contentView.timeCounter.isHidden = true
            secondsRemaining = 90
            contentView.resendButton.isEnabled = true
            contentView.resetResendButton()
        }
    }

    @objc func resendButtonTapped() {
        if contentView.resendButton.isEnabled {
            contentView.wrongEmailErrorLabel.isHidden = true
            authenticateUserRequest()
        }
    }
}

