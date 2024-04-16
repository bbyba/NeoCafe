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
    var onBackNavigate: EmptyCompletion?
    var onBonusModalsNavigate: EmptyCompletion?

    var orderDetails: [Ito] = [
        Ito(id: 32, item: 32, itemName: "Суп грибной", quantity: 2, totalPrice: 360),
        Ito(id: 31, item: 31, itemName: "Пирожок с капустой", quantity: 1, totalPrice: 120),
        Ito(id: 29, item: 29, itemName: "Чай черный", quantity: 3, totalPrice: 300),
    ]

    var completeOrdersList: [OrderHistoryModel] = []
    var currentOrdersList: [OrderHistoryModel] = []

    func setupCompleteOrdersList() {
        completeOrdersList = [
            OrderHistoryModel(id: 1, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 2, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 3, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 4, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
        ]
    }

    func setupCurrentOrdersList() {
        currentOrdersList =  [
            OrderHistoryModel(id: 5, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 6, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 7, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
            OrderHistoryModel(id: 8, orderNumber: 1, orderStatus: "Новый", orderType: "Takeaway", createdAt: "15:22", updatedAt: "15:22", completedAt: "15:22", branch: 1, branchName: "Backend", totalSum: "1000", customerProfile: "string", ito: orderDetails, bonusPointsToSubtract: 20),
        ]
    }
}
