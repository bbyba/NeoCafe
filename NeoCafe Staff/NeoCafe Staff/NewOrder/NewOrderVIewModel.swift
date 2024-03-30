//
//  NewOrderVIewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onOrderDetailsNavigate: EmptyCompletion? { get set }
    var onTableOrdersNavigate: EmptyCompletion? { get set }
}

class NewOrderViewModel: NSObject, NewOrderViewModelProtocol {
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
}
