//
//  ProfileViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol ProfileViewModelProtocol {
    var onEditProfileNavigate: EmptyCompletion? { get set }
    var personalData: CustomerProfile?  { get }
    var orders: [OrderHistoryModel]?  { get }
}

class ProfileViewModel: NSObject, ProfileViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onEditProfileNavigate: EmptyCompletion?
    var onPersonalDataFetched: ((CustomerProfile) -> Void)?
    var personalData: CustomerProfile?
    var orders: [OrderHistoryModel]?

    override init() {
        self.personalData = nil
    }

    func getPersonalData() {
        guard let userID = UserDefaultsService.shared.customerProfile?.userID else {
            let error = NSError(domain: "ProfileViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "User ID is nil"])
            return
        }

        networkService.sendRequest(successModelType: CustomerProfile.self,
                                   endpoint: MultiTarget(UserAPI.getProfile(userID: userID))) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.personalData = response
                    self.onPersonalDataFetched?(response)
                case .failure(let error):
                    print("handle error: \(error)")
                }
            }
        }
    }
}



