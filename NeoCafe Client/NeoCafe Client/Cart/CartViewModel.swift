//
//  CartViewModel.swift
//  NeoCafe Client
//

import Moya
import UIKit

protocol CartViewModelProtocol {
    var onMainMenuNavigate: EmptyCompletion? { get set }
    var onBonusModalsNavigate: EmptyCompletion? { get set }
    var onOrderHistoryNavigate: EmptyCompletion? { get set }
}

class CartViewModel: NSObject, CartViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onMainMenuNavigate: EmptyCompletion?
    var onBonusModalsNavigate: EmptyCompletion?
    var onOrderHistoryNavigate: EmptyCompletion?
    var totalPrice: Int = 0
    var orderList: [Item: Int] = [:]
}
