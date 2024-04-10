//
//  OrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol OrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
//    var onOrderDetailsNavigate: EmptyCompletion? { get set }
    var onTableOrdersNavigate: EmptyCompletion? { get set }

    var tables: [TableModel] { get set }
    var ordersList: [OrderDetailsModel] {  get set }
}

class OrderViewModel: NSObject, OrderViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onOrderDetailsNavigate: ((OrderDetailsModel) -> Void)?
    var onTableOrdersNavigate: EmptyCompletion?

    var onAllOrdersFetched: (() -> Void)?

    var tables: [TableModel]  = []
    var statusList: [String] = [
        S.all, S.newStatus, S.processingStatus, S.readyStatus, S.doneStatus, S.cancelledStatus
    ]

    var ordersList: [OrderDetailsModel] = []
//    var singleOrder: [OrderDetailsModel] = []
    var filteredOrders: [OrderDetailsModel] = []

    func filterOrders(byStatus status: String) {
        if status == S.all {
            filteredOrders = ordersList
        } else {
            filteredOrders = ordersList.filter { $0.orderStatus == status }
        }
    }

    func getAllOrders() {
        networkService.sendRequest(
            successModelType: [OrderDetailsModel].self,
            endpoint: MultiTarget(UserAPI.getOrdersAll(branchID: UserDefaultsService.shared.branchID))
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.ordersList = response
                    self.onAllOrdersFetched?()
                    print("ordersList: \(self.ordersList)")
                }
                print(response)
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }
}
