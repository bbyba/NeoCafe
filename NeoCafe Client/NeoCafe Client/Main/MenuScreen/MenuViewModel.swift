//
//  MenuViewModel.swift
//  NeoCafe Client
//

import UIKit
import Moya

protocol MenuViewModelProtocol {
    var onSearchNavigate: EmptyCompletion? { get set }
    var onBranchesNavigate: EmptyCompletion? { get set }
    var onProducDetailNavigate: EmptyCompletion? { get set }

    var categories: [CategoryModel]  { get }
    var menuItems: [Item] { get }
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
    func getMenuItems(completion: @escaping (Result<AllMenuItems, Error>) -> Void)
}


class MenuViewModel: NSObject, MenuViewModelProtocol {
    
    var onBranchesNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onProducDetailNavigate: EmptyCompletion?
    var categories: [CategoryModel] = []
    var menuItems: [Item] = []
    let provider: MoyaProvider<UserAPI>

    override init() {
            self.provider = MoyaProvider<UserAPI>()
            self.categories = []
        }

//    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
//        provider.request(.getCategories) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let categories = try JSONDecoder().decode([CategoryModel].self, from: response.data)
//                    print("Fetched Categories:")
//                    self.categories.forEach { category in
//                        print("ID: \(category.id), Name: \(category.name), Image: \(category.image)")
//                    }
//                    completion(.success(self.categories))
//                } catch {
//                    print("Error decoding categories: \(error)")
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                print("Error fetching categories: \(error)")
//                completion(.failure(error))
//            }
//        }
//    }
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
      provider.request(.getCategories) { result in
        switch result {
        case .success(let response):
            do {
                let categories = try JSONDecoder().decode([CategoryModel].self, from: response.data)
                self.categories = categories
                print("Fetched Categories:")
                categories.forEach { category in
                    print("ID: \(category.id), Name: \(category.name), Image: \(category.image)")
                }
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


//    func getMenuItems(completion: @escaping (Result<[Item], Error>) -> Void) {
//        provider.request(.getAllMenuItems) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let menuItems = try JSONDecoder().decode(AllMenuItems.self, from: response.data)
//                    self.menuItems = menuItems.results
//                    print("Fetched Menu Items:")
//                    self.menuItems.forEach { menuItem in
//                        print("ID: \(menuItem.id), Name: \(menuItem.name), Price: \(menuItem.pricePerUnit), desc: \(menuItem.description)")
//                    }
//                    completion(.success(self.menuItems))
//                } catch {
//                    print("Error decoding menu items: \(error)")
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                print("Error fetching menu items: \(error)")
//                completion(.failure(error))
//            }
//        }
//    }
    func getMenuItems(completion: @escaping (Result<AllMenuItems, Error>) -> Void) {
        provider.request(.getAllMenuItems) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        // Decode the whole response into an AllMenuItems object
                        let allMenuItems = try JSONDecoder().decode(AllMenuItems.self, from: response.data)
                        // Extract the array of items
                        let menuItems = allMenuItems.results
                        self?.menuItems = menuItems
                        print("Fetched Menu Items:")
                        menuItems.forEach { item in
                            print("ID: \(item.id), Name: \(item.name), Price: \(item.pricePerUnit), Description: \(item.description)")
                        }
                        completion(.success(allMenuItems))
                    } catch {
                        print("Error decoding menu items: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Error fetching menu items: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }

}
