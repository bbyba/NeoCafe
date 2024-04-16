//
//  BonusModalViewModel.swift
//  NeoCafe Client
//

import Foundation

protocol BonusModalViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion? { get set }
}

class BonusModalViewModel: NSObject, BonusModalViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBonusModalsNavigate: EmptyCompletion?
    var orderMadeSuccessfully: EmptyCompletion?

    func makeOrder() {
        let orderModel = createOrderList()

        networkService.sendRequest(successModelType: String.self,
                                   endpoint: MultiTarget(UserAPI.makeOrder(order: orderModel))) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                print("Request Successful")
                print("\(orderModel)")
                self.orderMadeSuccessfully?()
            case .failure(let error):
                print("Handle error: \(error)")
            }
        }
    }

    func createOrderList() -> NewOrderModelFinal {
        let itoArray: [Ito] = Cart.shared.createOrderListForSubmission()
        let branch = UserDefaultsService.BranchData.branchID.hashValue
        let orderType = "Takeaway"
        let bonusPointsToSubtract = 0
        let orderModel = NewOrderModelFinal(ito: itoArray, orderType: orderType, branch: branch, bonusPointsToSubtract: bonusPointsToSubtract)
        return orderModel
    }
}
