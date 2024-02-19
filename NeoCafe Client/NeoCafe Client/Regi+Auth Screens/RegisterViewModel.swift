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

class AuthViewModel {
    let provider = MoyaProvider<UserService>()
//    var currentState: ViewState = .signIn       // Maybe use didSet??
    var currentState: ViewState = .signIn {
        didSet {
            if currentState == .codeConfirmation {
                previousState = oldValue
            }
            self.updateViewState?(currentState)
        }
    }
    var previousState: ViewState?
    var emailValidationFailed: Bool = false
    var updateViewState: ((ViewState) -> Void)?
    var updateEmailValidationState: ((Bool) -> Void)?

    func validateEmail(email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        emailValidationFailed = !emailTest.evaluate(with: email)
    }

    func changeViewState(to newState: ViewState) {
        self.currentState = newState
    }

    func requestConfirmationCode(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        switch currentState {
        case .signIn:
            print("sign send code request")
            provider.request(.checkEmailLogin(email: email)) { result in
                self.handleResult(result, completion: completion)
            }
        case .registration:
            print("registration send code request")
            provider.request(.checkEmailRegister(email: email)) { result in
                self.handleResult(result, completion: completion)
            }
        case .codeConfirmation:
            break
        }
    }

    func registerLoginUser(email: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        switch currentState {
        case .signIn:
            print("sign confirm request")
            provider.request(.loginUser(email: email, confirmationCode: confirmationCode)) { result in
                self.handleResult(result, completion: completion)
            }
        case .registration:
            print("registration confirm request")
            provider.request(.registerUser(email: email, confirmationCode: confirmationCode)) { result in
                self.handleResult(result, completion: completion)
            }
        case .codeConfirmation:
            provider.request(.registerUser(email: email, confirmationCode: confirmationCode)) { result in
                self.handleResult(result, completion: completion)
            }
        }
    }

//    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping (Result<Void, Error>) -> Void) {
//        switch result {
//        case .success(let response):
//            print("Request succeeded with status code: \(response.statusCode)")
//            if let responseString = String(data: response.data, encoding: .utf8) {
//                print("Response data: \(responseString)")
//            }
//            completion(.success(()))
//        case .failure(let error):
//            print("Request failed with error: \(error.localizedDescription)")
//            if let response = error.response {
//                // Additionally, print the error status code and error response body if available
//                print("Error status code: \(response.statusCode)")
//                if let errorResponseString = String(data: response.data, encoding: .utf8) {
//                    print("Error response data: \(errorResponseString)")
//                }
//            }
//            completion(.failure(error))
//        }
//    }

    private func handleResult(_ result: Result<Response, MoyaError>, completion: @escaping (Result<Void, Error>) -> Void) {
        switch result {
        case .success(let response):
            if (200...299).contains(response.statusCode) {
                print("Request succeeded with status code: \(response.statusCode)")
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.success(()))
            } else {
                print("Request completed with error status code: \(response.statusCode)")
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Error response data: \(responseString)")
                }
                let errorResponse = NSError(domain: "com.neocafe.client.error", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP status code: \(response.statusCode)"])
                completion(.failure(errorResponse))
            }

        case .failure(let error):
            print("Networking request failed with error: \(error.localizedDescription)")
            if let response = error.response {
                print("Error status code: \(response.statusCode)")
                if let errorResponseString = String(data: response.data, encoding: .utf8) {
                    print("Error response data: \(errorResponseString)")
                }
            }
            completion(.failure(error))
        }
    }
}
