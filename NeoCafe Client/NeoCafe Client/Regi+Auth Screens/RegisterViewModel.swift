//
//  RegisterViewModel.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit

enum ViewState {
    case signIn
    case registration
    case codeConfirmation
}

class AuthViewModel {
    var currentState: ViewState = .signIn       // Maybe use didSet??
    var emailValidationFailed: Bool = false
    var updateViewState: ((ViewState) -> Void)?
    var updateEmailValidationState: ((Bool) -> Void)?

    func validateEmail(email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        emailValidationFailed = !emailTest.evaluate(with: email)
    }

    // Method to change the current view state
    func changeViewState(to newState: ViewState) {
        self.currentState = newState
    }
}
