//
//  AuthenticationViewController.swift
//  NeoCafe Client
//

import Moya
import UIKit

class AuthenticationViewController: BaseViewController<AuthViewModel, BaseAuthRegView> {
    var timer: Timer?
    var secondsRemaining = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        viewModel.onCodeConfirmationNavigate = { [weak self] in
            self?.switchToCodeConfirmation()
        }
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
            viewModel.requestConfirmationCode(email: email)
        }
    }

    private func requestCodeButton() {
        handleCodeRequest()
    }

    private func authenticateUserRequest() {
        let code = contentView.codeConfirmationView.otpField.getPin()
        guard let storedEmail = viewModel.storedEmail else {
            print("Email is not stored or code is nil")
            return
        }

        viewModel.authenticateUser(email: storedEmail, confirmationCode: code)
    }

    func switchToCodeConfirmation() {
        contentView.showCodeConfirmationView()
        startTimer()
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let newState: ViewState = sender.selectedSegmentIndex == 0 ? .signIn : .registration
        viewModel.changeViewState(to: newState)
        contentView.updateViewForSegmentIndex(index: newState == .signIn ? 0 : 1)
    }

    @objc private func getCodeButtonTapped() {
        switch viewModel.currentState {
        case .codeConfirmation:
            authenticateUserRequest()
        default:
            requestCodeButton()
        }
    }
}

extension AuthenticationViewController {
    // MARK: - Timer logic

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
