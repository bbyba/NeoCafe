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
    var allCategories: [CategoryModel] { get }
    func getAllCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}

class MenuViewModel: NSObject, MenuViewModelProtocol {
    var onBranchesNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onProductDetailNavigate: EmptyCompletion?
    var allCategories: [CategoryModel] = []
    let provider: MoyaProvider<UserAPI>

    override init() {
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
}
