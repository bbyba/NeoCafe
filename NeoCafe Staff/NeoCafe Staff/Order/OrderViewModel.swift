//
//  OrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

struct OrderModel {
    let tableNumber: Int
    let orderNumber: Int
    let status: String
    let time: String
}

protocol OrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onOrderDetailsNavigate: EmptyCompletion? { get set }
    var onTableOrdersNavigate: EmptyCompletion? { get set }

    var tables: [TableModel] { get set }
    var ordersList: [OrderModel] {  get set }

//    func getTables()
}

class OrderViewModel: NSObject, OrderViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onOrderDetailsNavigate: EmptyCompletion?
    var onTableOrdersNavigate: EmptyCompletion?

    var onTablesFetched: (() -> Void)?

    var tables: [TableModel]  = []

    var ordersList: [OrderModel] = [
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Новый", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Готово", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Новый", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "В процессе", time: "19:02"),
    ]

    var categories: [String] = [
        S.all, S.newStatus, S.processingStatus, S.readyStatus, S.doneStatus, S.cancelledStatus
    ]

//    func getTables() {
//        networkService.sendRequest(successModelType: [TableModel].self,
//                                   endpoint: MultiTarget(UserAPI.getTablesByBranch(branchID: UserDefaultsService.shared.branchID)))
//        { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    self.tables = response
//                    self.onTablesFetched?()
//                }
//                print(response)
//            case .failure(let error):
//                print("handle error: \(error)")
//            }
//        }
//    }
}
