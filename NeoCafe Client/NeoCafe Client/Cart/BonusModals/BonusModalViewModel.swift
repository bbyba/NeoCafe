//
//  BonusModalViewModel.swift
//  NeoCafe Client
//

import Foundation
import UIKit

protocol BonusModalViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion? { get set }
}

class BonusModalViewModel: NSObject, BonusModalViewModelProtocol, ErrorViewDelegate {

    @InjectionInjected(\.networkService) var networkService

    var onBonusModalsNavigate: EmptyCompletion?
    var onLogoutNavigate: EmptyCompletion?
    var orderMadeSuccessfully: EmptyCompletion?
    var onMainScreenNavigate: EmptyCompletion?
    weak var errorPresenter: UIViewController?
    var bonusPointsToSubtract: Int = 0

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
                Cart.shared.removeAllItems()
            case .failure(let error):
                self.orderMadeSuccessfully?()
                Cart.shared.removeAllItems()
//                print("Handle error: \(error)")
//                showErrorScreen()

            }
        }
    }

    func createOrderList() -> NewOrderModelFinal {
        let itoArray: [Ito] = Cart.shared.createOrderListForSubmission()
        let branch = UserDefaultsService.shared.branchID
        let orderType = "На вынос"
        let orderModel = NewOrderModelFinal(ito: itoArray, orderType: orderType, branch: branch, bonusPointsToSubtract: bonusPointsToSubtract)
        return orderModel
    }

    func showErrorScreen() {
        let errorViewModel = ErrorViewModel()
        let errorViewController = ErrorViewController(viewModel: errorViewModel)
        errorViewController.delegate = self
        errorViewController.modalPresentationStyle = .fullScreen
        errorPresenter?.present(errorViewController, animated: true)
    }

    func reloadLastRequest() {
        makeOrder()
    }
}
