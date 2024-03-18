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
    var orderList: [Ito]?  { get }
//    func postOrder(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class CartViewModel: NSObject, CartViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion?
    var orderList: [Ito]?

//    var onSearchNavigate: EmptyCompletion?
//    var onMenuNavigate: EmptyCompletion?
//    var categories: [CategoryModel] = []
//    let provider: MoyaProvider<UserAPI>


}
