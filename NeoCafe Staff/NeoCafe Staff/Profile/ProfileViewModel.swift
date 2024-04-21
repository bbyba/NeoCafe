//
//  ProfileViewModel.swift
//  NeoCafe Staff
//

import Moya
import UIKit

protocol ProfileViewModelProtocol {
    var onLogoutNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }
    func getProfile()
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onLogoutNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
    var profileData: ProfileResponse?
    var onProfileDataFetched: (() -> Void)?

    func getProfile() {
        networkService.sendRequest(successModelType: ProfileResponse.self,
                                   endpoint: MultiTarget(UserAPI.getProfile(userID: UserDefaultsService.shared.userID)))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.profileData = response
                    self.onProfileDataFetched?()
                    print(response)
                }
                print(response)
            case let .failure(error):
                print("handle error: \(error)")
            }
        }
    }
}
