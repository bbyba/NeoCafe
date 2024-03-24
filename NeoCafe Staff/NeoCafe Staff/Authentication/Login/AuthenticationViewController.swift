//
//  AuthenticationViewController.swift
//  NeoCafe Staff
//

import UIKit
import SwiftUI
import Moya

class AuthenticationViewController: BaseViewController<AuthViewModel, AuthenticationView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.getCodebutton.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
    }

    @objc private func getCodeButtonTapped() {
        viewModel.onCodeConfirmationNavigate?()
    }
}
