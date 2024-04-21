//
//  AuthenticationViewController.swift
//  NeoCafe Staff
//

import Moya
import SwiftUI
import UIKit

class AuthenticationViewController: BaseViewController<AuthenticationViewModel, AuthenticationView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.getCodebutton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
    }

    @objc private func getCodeButtonTapped() {
        guard let username = contentView.loginTextField.text, !username.isEmpty,
              let password = contentView.passwordTextField.text, !password.isEmpty
        else {
            return
        }

        viewModel.requestConfirmationCode(username: username, password: password)
    }
}
