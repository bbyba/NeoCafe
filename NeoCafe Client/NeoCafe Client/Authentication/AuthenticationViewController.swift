//
//  AuthenticationViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI
import Moya

class AuthenticationViewController: UIViewController {
    private lazy var baseAuthRegView = BaseAuthRegView()
    //    private var viewModel = AuthViewModel()
    private var viewModel = AuthViewModelImpl(provider: MoyaProvider<UserAPI>())

    var timer: Timer?
    var secondsRemaining = 5

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
        baseAuthRegView.resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }

    private func getEmailString() -> String? {
        switch viewModel.currentState {
        case .signIn:
            return baseAuthRegView.signInView.emailTextField.text
        case .registration:
            return baseAuthRegView.registrationView.emailTextFieldReg.text
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
        baseAuthRegView.wrongEmailErrorLabel.isHidden = isValid

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
        print("getCodeButtonTapped")
        handleCodeRequest()
    }

    private func getCodeString() -> String? {
        baseAuthRegView.codeConfirmationView.otpField.getPin()
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

        print("confirm button tapped")
        print("\(storedEmail) and \(code)")

//        viewModel.authenticateUser(email: storedEmail, confirmationCode: code) { result in
        viewModel.authenticateUser(email: storedEmail, confirmationCode: code) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Success: authenticateUser")
                    self?.viewModel.onMainNavigate?()
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.baseAuthRegView.updateResendButtonAttributedTitle()
                }
            }
        }

    }


    func switchToCodeConfirmation() {
        viewModel.changeViewState(to: .codeConfirmation)
        baseAuthRegView.showCodeConfirmationView()
        startTimer()
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
            print("authenticateUserRequest")
            authenticateUserRequest()
        default:
            print("current viewstate: \(self.viewModel.currentState)")
            print("requestCodeButton")
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
            baseAuthRegView.timeCounter.text = timeString(time: TimeInterval(secondsRemaining))
            baseAuthRegView.resendButton.isEnabled = false
        } else {
            timer?.invalidate()
            baseAuthRegView.timeCounter.isHidden = true
            secondsRemaining = 90
            baseAuthRegView.resendButton.isEnabled = true
            baseAuthRegView.resetResendButton()
        }
    }

    @objc func resendButtonTapped() {
        print("resendButtonTapped")
        if baseAuthRegView.resendButton.isEnabled {
            baseAuthRegView.wrongEmailErrorLabel.isHidden = true
            authenticateUserRequest()
        }
    }
}
