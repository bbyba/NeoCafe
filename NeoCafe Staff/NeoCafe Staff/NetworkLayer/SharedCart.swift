//
//  SharedCart.swift
//  NeoCafe Staff
//

import Foundation

protocol CartUpdateDelegate: AnyObject {
    func cartDidUpdate()
}

class Cart {
    static let shared = Cart()

    var items: [Item: Int] = [:]
    weak var delegate: CartUpdateDelegate?

    init() {}

    func addItem(_ item: Item, quantity: Int? = 1) {
        if let existingQuantity = items[item] {
            if let quantity = quantity {
                items[item] = existingQuantity + quantity
            } else {
                items[item] = existingQuantity + 1
            }
        } else {
            items[item] = quantity ?? 1
        }
        delegate?.cartDidUpdate()
    }

    func removeItem(_ item: Item) {
        items.removeValue(forKey: item)
        delegate?.cartDidUpdate()
    }

    func removeAllItems() {
        items.removeAll()
        delegate?.cartDidUpdate()
    }

    func getItems() -> [(item: Item, quantity: Int)] {
        return items.map { ($0.key, $0.value) }
    }

    func getTotalPrice() -> Int {
        return items.reduce(0) { $0 + Int($1.key.pricePerUnit * $1.value) }
    }

    func createOrderListForSubmission() -> [ITO] {
        return items.map { item, quantity in
            let totalPrice = item.pricePerUnit * quantity
            return ITO(id: item.id, item: item.id, itemName: item.name, quantity: quantity, totalPrice: totalPrice)
        }
    }
}
