//
//  MainViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol MainViewModelProtocol {
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onSearchNavigate: EmptyCompletion? { get set }
    var onMenuNavigate: EmptyCompletion? { get set }
    var onAddToCartNavigate: EmptyCompletion? { get set }
    var onBranchesModalNavigate: EmptyCompletion? { get set }
    var selectedBranchID: Int? { get set }
    var selectedBranchName: String? { get set }
    var categories: [CategoryModel]  { get }
    var popularItems: [Item] { get }
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getPopularItems(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void)
}


class MainViewModel: NSObject, MainViewModelProtocol {
    var onNotificationsNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onMenuNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?
    var onBranchesModalNavigate: EmptyCompletion?
    var selectedBranchID: Int?
    var selectedBranchName: String?
    var categories: [CategoryModel] = []
    var popularItems: [Item] = []
    let provider: MoyaProvider<UserAPI>

    override init() {
        self.provider = MoyaProvider<UserAPI>()
        super.init()
        self.categories = []
        self.popularItems = []
    }

    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        provider.request(.getCategories) { result in
            switch result {
            case .success(let response):
                do {
                    let categories = try JSONDecoder().decode([CategoryModel].self, from: response.data)
                    self.categories = categories.prefix(5).map { $0 }
                    completion(.success(self.categories))
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

    func getPopularItems(branchID: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        provider.request(.getPopularItems(branchID: branchID)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let popularItems = try JSONDecoder().decode([Item].self, from: response.data)
                        self?.popularItems = popularItems
                        completion(.success(popularItems))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
