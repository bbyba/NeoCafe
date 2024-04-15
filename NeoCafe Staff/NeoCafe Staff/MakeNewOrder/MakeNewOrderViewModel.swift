//
//  MakeNewOrderViewModel.swift
//  NeoCafe Staff
//
import Foundation

protocol MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
//    var orderedItems: [WaiterItem] {  get set }
}

class MakeNewOrderViewModel: NSObject, MakeNewOrderViewModelProtocol {
    var onBackNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
    var cart: Cart
    var table: TableModel

    init(cart: Cart, table: TableModel) {
        self.cart = cart
        self.table = table
        super.init()
    }
}
