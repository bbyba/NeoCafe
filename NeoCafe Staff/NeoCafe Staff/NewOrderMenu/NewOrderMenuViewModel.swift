//
//  NewOrderMenuViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya

protocol NewOrderMenuViewModelProtocol {

    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }


    var onTableNavigate: EmptyCompletion? { get set }
    var onSearchNavigate: EmptyCompletion? { get set }
    var onCategoryNavigate: EmptyCompletion? { get set }
    var onAddItemNavigate: EmptyCompletion? { get set }

    var allCategories: [CategoryModel] { get }
    var menuItems: [Item] { get }
}

class NewOrderMenuViewModel: NSObject, NewOrderMenuViewModelProtocol {
    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?

    var onTableNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onCategoryNavigate: EmptyCompletion?
    var onAddItemNavigate: EmptyCompletion?

    var allCategories: [CategoryModel] = [
        CategoryModel(id: 1, name: "Кофе", image: nil),
        CategoryModel(id: 2, name: "Десерты", image: nil),
        CategoryModel(id: 3, name: "Выпечка", image: nil),
        CategoryModel(id: 4, name: "Tea", image: nil),
        CategoryModel(id: 5, name: "Brunch", image: nil),
    ]

    var menuItems: [Item] = [
        Item(id: 1, name: "Латте", description: "Delicious coffee", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 1, name: "Кофе", image: nil), ingredients: nil),
        Item(id: 2, name: "Капучино", description: "Delicious coffee", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 1, name: "Кофе", image: nil), ingredients: nil),
        Item(id: 3, name: "Cake", description: "m", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 2, name: "Десерты", image: nil), ingredients: nil),
        Item(id: 4, name: "Croissant", description: "cc", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 3, name: "Выпечка", image: nil), ingredients: nil),
        Item(id: 5, name: "Green Tea", description: "Delicious coffee", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 4, name: "Tea", image: nil), ingredients: nil),
        Item(id: 6, name: "Waffles", description: "Delicious coffee", itemImage: nil, pricePerUnit: 140, branch: nil, category: CategoryModel(id: 5, name: "Brunch", image: nil), ingredients: nil),
    ]

    var filteredMenuItems: [Item] = []

    func filterMenuItems(byCategory category: CategoryModel) {
        filteredMenuItems = menuItems.filter { $0.category.id == category.id }
    }

    override init() {
        super.init()
        setupFirstCategory()
    }

    private func setupFirstCategory() {
        if let firstCategory = allCategories.first {
            filterMenuItems(byCategory: firstCategory)
        }
    }
}
