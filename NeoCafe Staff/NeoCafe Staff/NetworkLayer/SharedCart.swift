//
//  SharedCart.swift
//  NeoCafe Staff
//

import Foundation

class Cart {
    static let shared = Cart()

    //    var items: [Item] = []
    var items: [Item: Int] = [:]

    init() {}

    func addItem(_ item: Item) {
        if let quantity = items[item] {
            items[item] = quantity + 1
        } else {
            items[item] = 1
        }
    }

    func removeItem(_ item: Item) {
        items.removeValue(forKey: item)
    }

    func removeAllItems() {
        items.removeAll()
    }

    func getItems() -> [(item: Item, quantity: Int)] {
        return items.map { ($0.key, $0.value) }
    }

    func getTotalPrice() -> Double {
        return items.reduce(0.0) { $0 + Double($1.key.pricePerUnit * $1.value) }
    }

    func convertToIto() -> [Ito] {
        return items.map { (item, quantity) in
            let totalPrice = String(item.pricePerUnit * quantity)
            return Ito(id: item.id, item: item.id, itemName: item.name, quantity: quantity, totalPrice: totalPrice)
        }
    }
}
