//
//  MenuViewModel.swift
//  NeoCafe Staff
//

import UIKit
import Moya
import RealmSwift

protocol MenuViewModelProtocol {

    var onProfileNavigate: EmptyCompletion? { get set }
    var onNotificationsNavigate: EmptyCompletion? { get set }
    var onMakeNewOrderPopupNavigate: EmptyCompletion? { get set }
    var onBackNavigate: EmptyCompletion? { get set }

    var onTableNavigate: EmptyCompletion? { get set }
    var onSearchNavigate: EmptyCompletion? { get set }
    var onCategoryNavigate: EmptyCompletion? { get set }
    var onAddItemNavigate: EmptyCompletion? { get set }

    var allCategories: [CategoryModel] { get }
    var menuItems: [Item] { get }

    func getCategories()
    func getMenuItems()
}

class MenuViewModel: NSObject, MenuViewModelProtocol {
    @InjectionInjected(\.networkService) var networkService
    let realm = try! Realm()

    var onProfileNavigate: EmptyCompletion?
    var onNotificationsNavigate: EmptyCompletion?
    var onMakeNewOrderPopupNavigate: EmptyCompletion?
    var onBackNavigate: EmptyCompletion?

    var onTableNavigate: EmptyCompletion?
    var onSearchNavigate: EmptyCompletion?
    var onCategoryNavigate: EmptyCompletion?
    var onAddItemNavigate: EmptyCompletion?

    var onCategoriesFetched: (() -> Void)?
    var onMenuItemsFetched: (() -> Void)?

    var allCategories: [CategoryModel] = []
    var menuItems: [Item] = []

    var filteredMenuItems: [Item] = []

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
                }            case .failure(let error):
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
                    self.saveMenuItemsToRealm()
                    self.onMenuItemsFetched?()
                }
            case .failure(let error):
                print("Error fetching menu items: \(error)")
            }
        }
    }

    private func saveMenuItemsToRealm() {
            do {
                let realm = try Realm()
                try realm.write {
                    for menuItem in menuItems {
                        if realm.object(ofType: ItemRealmModel.self, forPrimaryKey: menuItem.id) == nil {
                            let itemRealm = ItemRealmModel(from: menuItem)
                            realm.add(itemRealm)
                        }
                    }
                }
            } catch {
                print("Error saving menu items to Realm: \(error)")
            }
        }
    
        func itemsExistInRealm() -> Bool {
                do {
                    let realm = try Realm()
                    let items = realm.objects(ItemRealmModel.self)
                    return !items.isEmpty
                } catch {
                    print("Error checking if items exist in Realm: \(error)")
                    return false
                }
            }
}

extension MenuViewModel {
    func filterMenuItems(byCategory category: CategoryModel) {
        filteredMenuItems = menuItems.filter { $0.category?.id == category.id }
    }
}
