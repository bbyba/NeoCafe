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
    var selectedBranchID: Int? { get set }
    var selectedBranchName: String? { get set }
    func getAllCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
//    func getMenuItemsByBranchCategory(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void)
}

class MenuViewModel: NSObject, MenuViewModelProtocol {
    var onSearchNavigate: EmptyCompletion?
    var onBranchesNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?
    var onProductDetailNavigate: ((Int) -> Void)?

    var onCategoriesFetched: (() -> Void)?
    var onMenuItemsFetched: (() -> Void)?

    var allCategories: [CategoryModel] = []
    var menuItems: [Item] = []
    var selectedBranchID: Int?
    var selectedBranchName: String?
    //    var categoryID: Int


    var filteredMenuItems: [Item] = []

        func filterMenuItems(byCategory category: CategoryModel) {
            filteredMenuItems = menuItems.filter { $0.category.id == category.id }
        }


    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
    }

    private func setupFirstCategory() {
           if let firstCategory = allCategories.first {
               filterMenuItems(byCategory: firstCategory)
           }
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
                        self?.onCategoriesFetched?()
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

    func getMenuItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        provider.request(.getMenuItemsAll) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let allMenuItems = try JSONDecoder().decode(AllMenuItems.self, from: response.data)
                        print("\(allMenuItems)")
                        self?.menuItems = allMenuItems.results.results
                        completion(.success(allMenuItems.results.results))
                        self?.onMenuItemsFetched?()
//                        print("\(allMenuItems.results)")
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
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        onAddToCartNavigate?()
    }
}




//    func getMenuItemsByBranchCategory(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
//        provider.request(.getMenuItemsByBranchCategory(branchID: branchID)) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    do {
//                        let menuItems = try JSONDecoder().decode([Item].self, from: response.data)
//                        self?.menuItems = menuItems
//                        completion(.success(menuItems))
//                    } catch {
//                        print("Error decoding menuItems: \(error)")
//                        completion(.failure(error))
//                    }
//                case .failure(let error):
//                    print("Error fetching menuItems: \(error)")
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
