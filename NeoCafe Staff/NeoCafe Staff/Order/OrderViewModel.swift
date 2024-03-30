//
//  OrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

struct TableModel {
    let tableNumber: Int
    let isBusy: Bool
}

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
}

class OrderViewModel: NSObject, OrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onOrderDetailsNavigate: EmptyCompletion?
    var onTableOrdersNavigate: EmptyCompletion?

    var tables: [TableModel]  = [
        TableModel(tableNumber: 1, isBusy: true),
        TableModel(tableNumber: 2, isBusy: false),
        TableModel(tableNumber: 3, isBusy: false),
        TableModel(tableNumber: 4, isBusy: false),
        TableModel(tableNumber: 5, isBusy: true),
        TableModel(tableNumber: 6, isBusy: false),
        TableModel(tableNumber: 7, isBusy: false),
    ]

    var ordersList: [OrderModel] = [
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Новый", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Готово", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "Новый", time: "19:02"),
        OrderModel(tableNumber: 1, orderNumber: 123, status: "В процессе", time: "19:02"),
    ]

    var categories: [String] = [
        S.all, S.newStatus, S.processingStatus, S.readyStatus, S.doneStatus, S.cancelledStatus
    ]
}
