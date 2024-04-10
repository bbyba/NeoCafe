//
//  RegisterViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

enum ViewState {
    case signIn
    case registration
    case codeConfirmation
}

protocol AuthViewModelProtocol {
    var onMainNavigate: EmptyCompletion? { get set }
    var onCodeConfirmationNavigate: EmptyCompletion? { get set }
    var currentState: ViewState { get }
    func changeViewState(to newState: ViewState)

    func validateEmail(email: String) -> Bool
//    func requestConfirmationCode(email: String, completion: @escaping (Result<Void, Error>) -> Void)
//    func authenticateUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthViewModel: NSObject, AuthViewModelProtocol {

    @InjectionInjected(\.networkService) var networkService

    var onMainNavigate: EmptyCompletion?
    var onCodeConfirmationNavigate: EmptyCompletion?
    var currentState: ViewState = .signIn {
        didSet {
            if currentState == .codeConfirmation {
                previousState = oldValue
            }
            self.updateViewState?(currentState)
        }
    }
    var previousState: ViewState?
    var storedEmail: String?
    var updateViewState: ((ViewState) -> Void)?
    var updateEmailValidationState: ((Bool) -> Void)?

    func changeViewState(to newState: ViewState) {
        self.currentState = newState
    }


    func storeEmail(email: String) {
        storedEmail = email
    }

    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    func requestConfirmationCode(email: String) {
        let action: UserAPI = currentState == .signIn ? .checkEmailLogin(email: email) : .checkEmailRegister(email: email)

        networkService.sendRequest(successModelType: MessageResponse.self,
                                   endpoint: MultiTarget(action))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.changeViewState(to: .codeConfirmation)
                    self.onCodeConfirmationNavigate?()
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }


    func authenticateUser(email: String, confirmationCode: String) {
        guard currentState == .codeConfirmation, let prevState = previousState else {
            print("Authentication can only be done in codeConfirmation state with a valid previous state.")
            return
        }
        
        let action: UserAPI = prevState == .signIn ? .loginUser(email: email,
                                                                confirmationCode: confirmationCode) :
                                                    .registerUser(email: email,
                                                                  confirmationCode: confirmationCode)

        networkService.sendRequest(successModelType: AuthResponseModel.self,
                                   endpoint: MultiTarget(action))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                     UserDefaultsService.shared.saveTokens(response: response)
                    self.onMainNavigate?()
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }

}
