//
//  TableOrderDetailsViewModel.swift
//  NeoCafe Staff
//

import Foundation

struct WaiterItem {
    let name: String
    let description: String
}

protocol TableOrderDetailsViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onCloseOrderNavigate: EmptyCompletion? { get set }
    var onAddNavigate: EmptyCompletion? { get set }
    var orderedItems: [WaiterItem] {  get set }
}

class TableOrderDetailsViewModel: NSObject, TableOrderDetailsViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onCloseOrderNavigate: EmptyCompletion?
    var onAddNavigate: EmptyCompletion?

    var orderedItems: [WaiterItem] = [
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп"),
        WaiterItem(name: "Латте (140 с за шт)", description: "Коровье молоко \nКарамельный сироп")
//        OrderDetailsModel(id: 1, orderNumber: 123, orderStatus: "Новый", createdAt: "19:02", updatedAt: nil, completedAt: nil, branch: 1, orderType: <#T##String#>, totalSum: 100, customer: 12, bonusPoints: 11, ito: [Ito])
    ]
}
