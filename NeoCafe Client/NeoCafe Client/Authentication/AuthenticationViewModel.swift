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
    var currentState: ViewState { get }
    func changeViewState(to newState: ViewState)

    func validateEmail(email: String) -> Bool
    func requestConfirmationCode(email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func authenticateUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class AuthViewModelImpl: AuthViewModelProtocol {
    var onMainNavigate: EmptyCompletion?
    let provider: MoyaProvider<UserAPI>
    //    var currentState: ViewState = .signIn
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

    init(provider: MoyaProvider<UserAPI>) {
        self.provider = provider
    }

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

    func requestConfirmationCode(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        switch currentState {
        case .signIn:
            provider.request(.checkEmailLogin(email: email)) { result in
                self.handleResult(result, completion: completion)
            }
        case .registration:
            provider.request(.checkEmailRegister(email: email)) { result in
                self.handleResult(result, completion: completion)
            }
        case .codeConfirmation:
            break
        }
    }

    func authenticateUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard currentState == .codeConfirmation, let prevState = previousState else {
            completion(.failure(NSError(domain: "neocafe.client", code: 0, userInfo: [NSLocalizedDescriptionKey: "Authentication can only be done in codeConfirmation state with a valid previous state."])))
            return
        }

        let action: UserAPI = prevState == .signIn ? .loginUser(email: email, confirmationCode: confirmationCode) : .registerUser(email: email, confirmationCode: confirmationCode)
        provider.request(action) { result in
            self.handleResult(result, completion: completion)
        }
    }


    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping (Result<Void, Error>) -> Void) {
        switch result {
        case .success(let response):
            if (200...299).contains(response.statusCode) {
                completion(.success(()))
            } else {
                let errorResponse = NSError(domain: "neocafe.client.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(response.statusCode)"])
                completion(.failure(errorResponse))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
