//
//  MenuViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol MenuViewModelProtocol {
    var onSearchNavigate: EmptyCompletion? { get set }
    var onBranchesNavigate: EmptyCompletion? { get set }
    var onAddToCartNavigate: EmptyCompletion? { get set }
    var onProductDetailNavigate: ((Int) -> Void)? { get set }
    var allCategories: [CategoryModel] { get }
    var menuItems: [Item] { get }
}

class MenuViewModel: NSObject, MenuViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onSearchNavigate: EmptyCompletion?
    var onBranchesNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?

    var onProductDetailNavigate: ((Int) -> Void)?
    var onCategoriesFetched: (() -> Void)?
    var onMenuItemsFetched: (() -> Void)?

    var allCategories: [CategoryModel] = []
    var menuItems: [Item] = []
    var selectedBranchID: Int? = UserDefaultsService.shared.branchID
    var selectedBranchName: String? = UserDefaultsService.shared.branchName


    var filteredMenuItems: [Item] = []

    func filterMenuItems(byCategory category: CategoryModel) {
        filteredMenuItems = menuItems.filter { $0.category.id == category.id }
    }

    private func setupFirstCategory() {
        if let firstCategory = allCategories.first {
            filterMenuItems(byCategory: firstCategory)
        }
    }

    func getCategories() {
        networkService.sendRequest(successModelType: [CategoryModel].self,
                                   endpoint: MultiTarget(UserAPI.getCategories))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.allCategories = response
                    self.onCategoriesFetched?()
                }
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }

    func getMenuItems() {
        networkService.sendRequest(successModelType: AllMenuItems.self,
                                   endpoint: MultiTarget(UserAPI.getMenuItemsAll))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.menuItems = response.results.results
                    self.onMenuItemsFetched?()
                }
            case .failure(let error):
                print("Error fetching menu items: \(error)")
            }
        }
    }

    func addToCart(menuItem: Item) {
        Cart.shared.addItem(menuItem)
        onAddToCartNavigate?()
    }
}
