//
//  BranchDetailViewModel.swift
//  NeoCafe Client
//

import Foundation
import Moya

protocol BranchesDetailViewModelProtocol {
    var onBackNavigate: EmptyCompletion? { get set }
    var onMenuNavigate: EmptyCompletion? { get set }
    var onPopularItemsFetched: EmptyCompletion? { get set }
    var branch: BranchModel? { get }
    var suggestionItems: [Item] { get }
}

class BranchDetailViewModel: NSObject, BranchesDetailViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onBackNavigate: EmptyCompletion?
    var onMenuNavigate: EmptyCompletion?
    var onPopularItemsFetched: EmptyCompletion?
    var branch: BranchModel?
//    var suggestionItems: [Item] = []

    var suggestionItems: [Item] = [
        Item( id: 31,
              name: "Пирожок с капустой",
              description: "Традиционное блюдо",
              itemImage: nil,
              pricePerUnit: 120,
              branch: nil,
              category: Category(id: 1, name: "Выпечка"),
              ingredients: nil),
        Item( id: 27,
              name: "Смузи с ягодами",
              description: "Освежающий напиток",
              itemImage: nil,
              pricePerUnit: 160,
              branch: nil,
              category: Category(id: 5, name: "Напитки"),
              ingredients: nil),
        Item( id: 32,
              name: "Суп грибной",
              description: "Ароматный и сытный",
              itemImage: nil,
              pricePerUnit: 180,
              branch: nil,
              category: Category(id: 7, name: "Супы"),
              ingredients: nil)]

//    func getSuggestionItems(branchID: Int) {
//        networkService.sendRequest(successModelType: [Item].self,
//                                   endpoint: MultiTarget(UserAPI.getPopularItems(branchID: branchID))) { [weak self] result in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    self.suggestionItems = response
//                    self.onPopularItemsFetched?()
//                case .failure(let error):
//                    print("handle error: \(error)")
//                }
//            }
//        }
//    }
    func addToCart(menuItem: Item) {
        Cart.shared.addItem(menuItem)
//        onAddToCartNavigate?()
    }
}
