//
//  CodeConfirmationViewController.swift
//  NeoCafe Staff
//

import UIKit

class CodeConfirmationViewController: BaseViewController<CodeConfirmationViewModel, CodeConfirmationView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func confirmButtonTapped() {
        let confirmationCode = contentView.otpField.getPin()
        if confirmationCode.isEmpty {
            return
        }
        viewModel.authenticate(confirmationCode: confirmationCode)
    }
}
