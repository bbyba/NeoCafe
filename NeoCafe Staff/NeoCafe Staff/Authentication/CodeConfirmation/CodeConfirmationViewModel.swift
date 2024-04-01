//
//  CodeConfirmationViewModel.swift
//  NeoCafe Staff
//
import UIKit
import Moya

protocol CodeConfirmationViewModelProtocol {
    var onMainNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
    func authenticate(confirmation_code: String)
}

class CodeConfirmationViewModel: NSObject, CodeConfirmationViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onMainNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
    var waiterEmail: String?

    func authenticate(confirmation_code: String) {
        guard let waiterEmail = waiterEmail else { return }
        networkService.sendRequest(successModelType: AuthenticationResponse.self,
                                   endpoint: MultiTarget(UserAPI.login(email: waiterEmail, 
                                                                       confirmation_code: confirmation_code)))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    UserDefaultsService.shared.saveTokensAndIDs(response: response)
                    self.onMainNavigate?()
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
}
