//
//  CartViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol CartViewModelProtocol {
    var onAddMoreNavigate: EmptyCompletion? { get set }
    var onOrderNavigate: EmptyCompletion? { get set }
//    var orderList: [Item]  { get }
//    func postOrder(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class CartViewModel: NSObject, CartViewModelProtocol {
    var onAddMoreNavigate: EmptyCompletion?
    var onOrderNavigate: EmptyCompletion?
    var totalPrice: Int = 0
//    var itemQuantities: [Int: Int] = [:]
    var orderList: [Item: Int] = [:]

}
