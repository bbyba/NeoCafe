//
//  NewOrderViewModel.swift
//  NeoCafe Staff
//

import Foundation

protocol NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
//    var onMakeNewOrderNavigate: EmptyCompletion? { get set }
    var onMakeNewOrderNavigate: ((TableModel) -> Void)? { get set }

}

class NewOrderViewModel: NSObject, NewOrderViewModelProtocol {
    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onMakeNewOrderNavigate: ((TableModel) -> Void)?
//    var onMakeNewOrderNavigate: EmptyCompletion?


//    var tables: [TableModel] = []
//    var cartsForTables: [TableModel: Cart] = [:]
    var selectedTable: TableModel?

//    func createCart(for table: TableModel) -> Cart {
//        if let cart = cartsForTables[table] {
//            print("Cart created for table ID: \(table.id)")
//            print("Existing Cart: \(cart)")
//            return cart
//        } else {
//            let newCart = Cart()
//            cartsForTables[table] = newCart
//            print("Cart created for table ID: \(table.id)")
//            print("New Cart: \(newCart)")
//            return newCart
//        }
//    }
}
