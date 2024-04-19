//
//  NewOrderMenuViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya
import RealmSwift

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

//    func getCategories()
//    func getMenuItems()
}

class NewOrderMenuViewModel: NSObject, NewOrderMenuViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService
    let realm = try! Realm()

    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?
    var onTableNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onCategoryNavigate: EmptyCompletion?
    var onAddItemNavigate: EmptyCompletion?

    var allCategories: [CategoryModel] = []
    var menuItems: [Item] = []

    var onCategoriesFetched: (() -> Void)?
    var onMenuItemsFetched: (() -> Void)?

    var onMakeNewOrderPopupNavigate: ((TableModel, OrderDetailsModel?) -> Void)?

    var filteredMenuItems: [Item] = []

    var separateCartsForTables: [TableModel: Cart] = [:]
    var cartsForTables: [TableModel: Cart] = [:]
    var selectedTable: TableModel
    var tables: [TableModel] = []
    var existingOrder: OrderDetailsModel?

    init(selectedTable: TableModel, existingOrder: OrderDetailsModel?) {
        self.selectedTable = selectedTable
        self.existingOrder = existingOrder
        super.init()
//        findItemsAndAdd()
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
                                   endpoint: MultiTarget(UserAPI.getMenuItems))
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

    func findItemsAndAdd() {
        guard let existingOrder = existingOrder else {
            print("existingOrder is nil")
            return }


        for ito in existingOrder.ito {
            if let item = findItemFromMenuItems(itemId: ito.id) {
                Cart.shared.addItem(item, quantity: ito.quantity)
            }
        }
    }

    private func findItemFromMenuItems(itemId: Int) -> Item? {
        let itemsInRealms = realm.objects(ItemRealmModel.self)
        for item in itemsInRealms {
            if item.id == itemId {
                let itemOfItemType = convertToItemType(itemRealm: item)
                return itemOfItemType
            }
        }
        return nil
    }


    private func convertToItemType(itemRealm: ItemRealmModel) -> Item {
        let item = Item(id: itemRealm.id,
                        name: itemRealm.name,
                        description: itemRealm.description,
                        itemImage: nil,
                        pricePerUnit: itemRealm.pricePerUnit,
                        branch: nil,
                        category: nil, ingredients: nil)
        return item
    }
}

extension NewOrderMenuViewModel {
    func filterMenuItems(byCategory category: CategoryModel) {
        filteredMenuItems = menuItems.filter { $0.category?.id == category.id }
    }
}
