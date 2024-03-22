//
//  MenuViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol MenuViewModelProtocol {
    var onSearchNavigate: EmptyCompletion? { get set }
    var onBranchesNavigate: EmptyCompletion? { get set }
    var onProductDetailNavigate: EmptyCompletion? { get set }
    var onAddToCartNavigate: EmptyCompletion? { get set }

    var allCategories: [CategoryModel] { get }
    var menuItems: [Item] { get }
    var selectedBranchID: Int? { get set }
    var selectedBranchName: String? { get set }
    func getAllCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}

class MenuViewModel: NSObject, MenuViewModelProtocol {
    var selectedBranchID: Int?
    var selectedBranchName: String?

    var onBranchesNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onProductDetailNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?

    var allCategories: [CategoryModel] = []
    var menuItems: [Item] = []
    var branchId: Int
    //    var categoryID: Int
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.branchId = 1
        self.provider = MoyaProvider<UserAPI>()
    }

    func getAllCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        provider.request(.getCategories) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let categories = try JSONDecoder().decode([CategoryModel].self, from: response.data)
                        self?.allCategories = categories
                        completion(.success(categories))
                    } catch {
                        print("Error decoding categories: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Error fetching categories: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }

    func getMenuItemsByBranchCategory(completion: @escaping (Result<[Item], Error>) -> Void) {
        //        provider.request(.getMenuItemsByBranchCategory(categoryID: self.categoryID)) { [weak self] result in
        provider.request(.getMenuItemsByBranchCategory(branchID: 1)) { [weak self] result in

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let menuItems = try JSONDecoder().decode([Item].self, from: response.data)
                        self?.menuItems = menuItems

                        print("Fetched menuItems:")
                        menuItems.forEach { menuItem in
                            print("ID: \(menuItem.id), Name: \(menuItem.name), price: \(menuItem.pricePerUnit), category: \(menuItem.category)")
                        }
                        completion(.success(menuItems))
                    } catch {
                        print("Error decoding menuItems: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Error fetching menuItems: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }

    func addToCart(menuItem: Item) {
        CartViewModel.shared.filterItems(newItem: menuItem)
        print("Added to cart: \(menuItem.name)")
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        onAddToCartNavigate?()
    }
}
