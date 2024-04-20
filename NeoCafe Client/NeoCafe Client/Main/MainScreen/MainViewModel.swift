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
    var categories: [CategoryModel]  { get }
    var popularItems: [Item] { get }
}


class MainViewModel: NSObject, MainViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService

    var onNotificationsNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onMenuNavigate: EmptyCompletion?
    var onAddToCartNavigate: EmptyCompletion?
    var onBranchesModalNavigate: EmptyCompletion?

    var onCategoriesFetched: EmptyCompletion?
    var onPopularItemsFetched: EmptyCompletion?
    var selectedBranchID: Int? = UserDefaultsService.shared.branchID
    var selectedBranchName: String? = UserDefaultsService.shared.branchName
//    var categories: [CategoryModel] = []
    var categories: [CategoryModel] = [
        CategoryModel(id: 1, name: "Выпечка", image: Asset.Menu.bakery.name),
        CategoryModel(id: 2, name: "Чай", image: Asset.Menu.tea.name),
        CategoryModel(id: 3, name: "Десерты", image: Asset.Menu.dessert.name),
        CategoryModel(id: 4, name: "Кофе", image: Asset.Menu.coffee.name),
        CategoryModel(id: 5, name: "Напитки", image: Asset.Menu.drink.name)]
    var popularItems: [Item] = [
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



    override init() {
        super.init()
//        self.categories = []
//        self.popularItems = []
    }


//    func getCategories() {
//        networkService.sendRequest(successModelType: [CategoryModel].self,
//                                   endpoint: MultiTarget(UserAPI.getCategories))
//        { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let response):
//                DispatchQueue.main.async {
//                    self.categories = response.prefix(5).map { $0 }
//                    print("\(self.categories)")
//                    self.onCategoriesFetched?()
//                }
//            case .failure(let error):
//                print("handle error: \(error)")
//            }
//        }
//    }

    func getPopularItems() {
        networkService.sendRequest(successModelType: [Item].self,
                                   endpoint: MultiTarget(UserAPI.getPopularItems(branchID: selectedBranchID ?? 1)))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("\(self.popularItems)")
                    self.onPopularItemsFetched?()
                }
            case .failure(let error):
                print("Error fetching menu items: \(error)")
            }
        }
    }

    func addToCart(menuItem: Item) {
        Cart.shared.addItem(menuItem)
//        onAddToCartNavigate?()
    }
}
