//
//  ProfileViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya

protocol ProfileViewModelProtocol {
    var onLogoutNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
//    func getProfile()
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onLogoutNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
    var profileData: ProfileResponse? {
            didSet {
                self.onProfileDataFetched?()
            }
        }
    var onProfileDataFetched: EmptyCompletion?

    func getProfile() {
        networkService.sendRequest(successModelType: ProfileResponse.self,
                                   endpoint: MultiTarget(UserAPI.getProfile(userID: UserDefaultsService.shared.userID)))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
//                    self.onMainNavigate?()
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
}
