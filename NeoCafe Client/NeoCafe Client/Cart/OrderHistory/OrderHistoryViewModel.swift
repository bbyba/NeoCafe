//
//  OrderHistoryViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol OrderHistoryViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onBonusModalsNavigate: EmptyCompletion? { get set }
}

class OrderHistoryViewModel: NSObject, OrderHistoryViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBackNavigate: EmptyCompletion?
    var onBonusModalsNavigate: EmptyCompletion?
    var onOrdersFetched: EmptyCompletion?
    var completeOrdersList: [OrderHistoryModel] = []
    var currentOrdersList: [OrderHistoryModel] = []

    func fetchOrderHistory() {
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
            case let .success(response):
                DispatchQueue.main.async {
                    self.currentOrdersList = response
                    print("getOrderHistoryNow: SUCCESSFUL \(self.currentOrdersList)")
                    completion()
                }
            case let .failure(error):
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
            case let .success(response):
                DispatchQueue.main.async {
                    self.completeOrdersList = response
                    print("getOrderHistoryPast: SUCCESSFUL")
                    completion()
                }
            case let .failure(error):
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
