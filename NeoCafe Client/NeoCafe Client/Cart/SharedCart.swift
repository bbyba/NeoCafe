//
//  SharedCart.swift
//  NeoCafe Client
//

import Foundation

class Cart {
    static let shared = Cart()

    var orderList: [Item: Int] = [:]

    init() {}

    func addItem(_ item: Item) {
        if let quantity = orderList[item] {
            orderList[item] = quantity + 1
        } else {
            orderList[item] = 1
        }
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func filterItems(newItem: Item, quantity: Int = 1) {
        if orderList.keys.contains(newItem) {
            orderList[newItem]! += quantity
        } else {
            orderList[newItem] = quantity
        }
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func removeItem(_ item: Item) {
        orderList.removeValue(forKey: item)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func removeAllItems() {
        orderList.removeAll()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }

    func getItems() -> [(item: Item, quantity: Int)] {
        orderList.map { ($0.key, $0.value) }
    }

    func getTotalPrice() -> Int {
        orderList.reduce(0) { $0 + Int($1.key.pricePerUnit * $1.value) }
    }

    func createOrderListForSubmission() -> [Ito] {
        orderList.map { item, quantity in
            let totalPrice = item.pricePerUnit * quantity
            return Ito(id: item.id, item: item.id, itemName: item.name, quantity: quantity, totalPrice: totalPrice)
        }
    }
}
