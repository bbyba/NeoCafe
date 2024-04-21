//
//  MenuViewController.swift
//  NeoCafe Staff
//

import RealmSwift
import UIKit

class MenuViewController: BaseViewController<MenuViewModel, MenuView> {
    var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        addTargets()
        Loader.shared.showLoader(view: view)
        viewModel.getCategories()
        viewModel.getMenuItems()
        setupBindings()
    }

    private func setDelegatesAndDataSource() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.allCategories.isEmpty == false && self?.viewModel.menuItems.isEmpty == false {
                    self?.selectFirstCategory()
                }
                self?.contentView.collectionView.reloadData()
                self?.checkIfDataLoadedThenHideLoader()
            }
        }

        viewModel.onMenuItemsFetched = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.menuItems.isEmpty == false && self?.viewModel.allCategories.isEmpty == false {
                    self?.selectFirstCategory()
                }
                self?.contentView.collectionView.reloadData()
                self?.checkIfDataLoadedThenHideLoader()
            }
        }
    }

    private func selectFirstCategory() {
        guard let firstCategory = viewModel.allCategories.first else { return }
        viewModel.filterMenuItems(byCategory: firstCategory)
        selectedCategoryIndex = 0
        contentView.collectionView.reloadData()
    }

    private func addTargets() {
        contentView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        contentView.notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
    }

    @objc private func profileButtonTapped() {
        viewModel.onProfileNavigate?()
    }

    @objc private func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }

    private func checkIfDataLoadedThenHideLoader() {
        if !viewModel.allCategories.isEmpty && !viewModel.menuItems.isEmpty {
            Loader.shared.hideLoader(view: view)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        return MenuSection.allCases.count
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MenuSection.allCases[section] {
        case .category:
            return viewModel.allCategories.count
        case .productItem:
            return viewModel.filteredMenuItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            let cell: CategoryCell = collectionView.dequeue(for: indexPath)
            let category = viewModel.allCategories[indexPath.row]
            cell.configureData(name: category.name)
            cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
            return cell

        case .productItem:
            let cell: MenuCell = collectionView.dequeue(for: indexPath)
            let menuItem = viewModel.filteredMenuItems[indexPath.row]
            cell.configureData(menuItem: menuItem, newOrderView: false)
            //            cell.onAddToCart = { [weak self] item in
            //                self?.viewModel.addToCart(menuItem: item)
            //            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if case .category = MenuSection.allCases[indexPath.section] {
            let category = viewModel.allCategories[indexPath.row]
            viewModel.filterMenuItems(byCategory: category)
            selectedCategoryIndex = indexPath.row
            collectionView.reloadData()
        }
    }
}
