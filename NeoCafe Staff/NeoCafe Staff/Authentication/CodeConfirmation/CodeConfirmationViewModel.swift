//
//  CodeConfirmationViewModel.swift
//  NeoCafe Staff
//
import Moya
import UIKit

protocol CodeConfirmationViewModelProtocol {
    var onMainNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
    func authenticate(confirmationCode: String)
}

class CodeConfirmationViewModel: NSObject, CodeConfirmationViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onMainNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
    var waiterEmail: String?

    func authenticate(confirmationCode: String) {
        guard let waiterEmail = waiterEmail else { return }
        networkService.sendRequest(successModelType: AuthenticationResponse.self,
                                   endpoint: MultiTarget(UserAPI.login(email: waiterEmail,
                                                                       confirmationCode: confirmationCode)))
        {
            [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    UserDefaultsService.shared.saveTokensAndIDs(response: response)
                    self.onMainNavigate?()
                }
                print(response)
            case let .failure(error):
                print("handle error: \(error)")
            }
        }
    }
}
