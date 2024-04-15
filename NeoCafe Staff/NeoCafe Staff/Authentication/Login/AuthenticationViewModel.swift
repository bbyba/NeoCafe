//
//  AuthenticationViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya

protocol AuthenticationViewModelProtocol {
    var onCodeConfirmationNavigate: EmptyCompletion? { get set }
    func requestConfirmationCode(username: String, password: String)
}

class AuthenticationViewModel: NSObject, AuthenticationViewModelProtocol {

    @InjectionInjected(\.networkService) var networkService

    var onCodeConfirmationNavigate: EmptyCompletion?
    var emailReceived: ((String) -> Void)?

    func requestConfirmationCode(username: String, password: String) {
        networkService.sendRequest(successModelType: ConfirmationResponse.self,
                                   endpoint: MultiTarget(UserAPI.requestConfirmationCode(username: username,
                                                                                         password: password)))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.emailReceived?(response.waiterEmail)
                    self.onCodeConfirmationNavigate?()
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
}
