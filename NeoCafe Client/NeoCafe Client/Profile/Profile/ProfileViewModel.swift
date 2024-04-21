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
    var onLogoutButtonTapped: EmptyCompletion?
    var onPersonalDataFetched: ((CustomerProfile) -> Void)?
    var personalData: CustomerProfile?
    var orders: [OrderHistoryModel]?

    var onOrdersFetched: EmptyCompletion?
    var completeOrdersList: [OrderHistoryModel] = []
    var currentOrdersList: [OrderHistoryModel] = []

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

    func fetchOrderHistory() {
        print("fetchOrderHistory() called")
        let group = DispatchGroup()

        group.enter()
        getOrderHistoryNow {
            group.leave()
        }

        group.enter()
        getOrderHistoryPast {
            group.leave()
        }

        group.notify(queue: .main) {
            self.onOrdersFetched?()
        }
    }

    private func getOrderHistoryNow(completion: @escaping () -> Void) {
        networkService.sendRequest(successModelType: [OrderHistoryModel].self,
                                   endpoint: MultiTarget(UserAPI.getOrderHistoryNow))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentOrdersList = response
                    print("getOrderHistoryNow: SUCCESSFUL)")
                    completion()
                }
            case .failure(let error):
                print("Error fetching current orders: \(error)")
                completion()
            }
        }
    }

    private func getOrderHistoryPast(completion: @escaping () -> Void) {
        networkService.sendRequest(successModelType: [OrderHistoryModel].self,
                                   endpoint: MultiTarget(UserAPI.getOrderHistoryPast))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.completeOrdersList = response
                    print("getOrderHistoryPast: SUCCESSFUL")
                    completion()
                }
            case .failure(let error):
                print("Error fetching past orders: \(error)")
                completion()
            }
        }
    }

    func makeITONameList(orderIto: [Ito]) -> String {
        var itemNameList = ""
        for (index, ito) in orderIto.enumerated() {
            itemNameList.append(ito.itemName)
            if index < orderIto.count - 1 {
                itemNameList.append(", ")
            }
        }
        return itemNameList
    }
}



