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
    var suggestionItems: [Item] = []

    func getSuggestionItems(branchID: Int) {
        networkService.sendRequest(successModelType: [Item].self,
                                   endpoint: MultiTarget(UserAPI.getPopularItems(branchID: branchID))) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.suggestionItems = response
                    self.onPopularItemsFetched?()
                case .failure(let error):
                    print("handle error: \(error)")
                }
            }
        }
    }

    func addToCart(menuItem: Item) {
        Cart.shared.addItem(menuItem)
    }
}
