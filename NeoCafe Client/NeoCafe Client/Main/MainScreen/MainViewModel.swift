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

    var categories: [CategoryModel]  { get }

//    func getCategories(_: CategoryModel, completion: @escaping (Result<Void, Error>) -> Void)
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}


class MainViewModel: NSObject, MainViewModelProtocol {
    var onNotificationsNavigate: EmptyCompletion?

    var onSearchNavigate: EmptyCompletion?

    var onMenuNavigate: EmptyCompletion?

    var categories: [CategoryModel] = []

    let provider: MoyaProvider<UserAPI>

    override init() {
            self.provider = MoyaProvider<UserAPI>()
            self.categories = []
        }

    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        provider.request(.getCategories) { result in
            switch result {
            case .success(let response):
                do {
                    let categories = try JSONDecoder().decode([CategoryModel].self, from: response.data)
                    self.categories = categories.prefix(5).map { $0 }

                    print("Fetched Categories:")
                    self.categories.forEach { category in
                        print("ID: \(category.id), Name: \(category.name), Image: \(category.image)")
                    }

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
}
