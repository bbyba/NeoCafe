//
//  CartViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol CartViewModelProtocol {
    var onAddMoreNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
    var orderList: [Item]  { get }
//    func postOrder(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class CartViewModel: NSObject, CartViewModelProtocol {
    static var shared = CartViewModel()
    var onAddMoreNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
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

    func filterItems(newItem: Item, quantity: Int = 1) {
        if orderList.firstIndex(where: { $0.id == newItem.id }) != nil {
            itemQuantities[newItem.id] = (itemQuantities[newItem.id] ?? 0) + quantity
        } else {
            orderList.append(newItem)
            itemQuantities[newItem.id] = quantity
        }
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func remove(item: Item) {
        // Find the index of the item in the orderList.
        if let index = orderList.firstIndex(where: { $0.id == item.id }) {
            // Remove the item from the list.
            orderList.remove(at: index)
            // Remove the item quantity from itemQuantities dictionary if exists.
            itemQuantities.removeValue(forKey: item.id)
        }
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
