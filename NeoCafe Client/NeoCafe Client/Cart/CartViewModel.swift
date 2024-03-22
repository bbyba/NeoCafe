//
//  CartViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol CartViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion? { get set }
//    var onSearchNavigate: EmptyCompletion? { get set }
//    var onMenuNavigate: EmptyCompletion? { get set }
    var orderList: [Item]  { get }
//    func postOrder(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class CartViewModel: NSObject, CartViewModelProtocol {
    static var shared = CartViewModel()
    var onBonusModalsNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
    var onMenuNavigate: EmptyCompletion?
    var totalPrice: Int = 0
    var itemQuantities: [Int: Int] = [:]


    var orderList: [Item] = [] {
        didSet {
            self.totalPrice = calculateTotalPrice()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        }
    }

    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
    }

    func filterItems(newItem: Item) {
        if let index = orderList.firstIndex(where: { item in item.id == newItem.id }) {
            itemQuantities[newItem.id] = (itemQuantities[newItem.id] ?? 0) + 1
        } else {
            orderList.append(newItem)
            itemQuantities[newItem.id] = 1
        }
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }


    func calculateTotalPrice() -> Int {
        var total: Int = 0
        for item in orderList {
            let quantity = itemQuantities[item.id] ?? 1 
            total += item.pricePerUnit * quantity
        }
        return total
    }

    func createOrderListForSubmission() -> [Ito] {
        return orderList.compactMap { item -> Ito? in
            guard let quantity = itemQuantities[item.id] else { return nil }
            let itemTotalPrice = item.pricePerUnit * quantity
            return Ito(id: item.id, item: item.id, itemName: item.name, quantity: quantity, totalPrice: itemTotalPrice)
        }
    }
}
