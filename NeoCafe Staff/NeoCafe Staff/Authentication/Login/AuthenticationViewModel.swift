//
//  AuthenticationViewModel.swift
//  NeoCafe Staff
//

import Moya
import UIKit

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
        {
            [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.emailReceived?(response.waiterEmail)
                    self.onCodeConfirmationNavigate?()
                }
                print(response)
            case let .failure(error):
                print("handle error: \(error)")
            }
        }
    }
}
