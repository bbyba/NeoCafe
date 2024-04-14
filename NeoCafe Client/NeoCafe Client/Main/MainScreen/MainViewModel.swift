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
    var categories: [CategoryModel] = []
    var popularItems: [Item] = []

    override init() {
        super.init()
        self.categories = []
        self.popularItems = []
    }


    func getCategories() {
        networkService.sendRequest(successModelType: [CategoryModel].self,
                                   endpoint: MultiTarget(UserAPI.getCategories))
        { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.categories = response.prefix(5).map { $0 }
                    self.onCategoriesFetched?()
                }
            case .failure(let error):
                print("handle error: \(error)")
            }
        }
    }

    func getPopularItems() {
        networkService.sendRequest(successModelType: [Item].self,
                                   endpoint: MultiTarget(UserAPI.getPopularItems(branchID: selectedBranchID ?? 1)))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.popularItems = response
                    self.onPopularItemsFetched?()
                }
            case .failure(let error):
                print("Error fetching menu items: \(error)")
            }
        }
    }
}
