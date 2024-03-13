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
//    var categories: [CategoryModel]  { get }
//    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class CartViewModel: NSObject, CartViewModelProtocol {
    var onBonusModalsNavigate: EmptyCompletion?
//    var onSearchNavigate: EmptyCompletion?
//    var onMenuNavigate: EmptyCompletion?
//    var categories: [CategoryModel] = []
//    let provider: MoyaProvider<UserAPI>


}
