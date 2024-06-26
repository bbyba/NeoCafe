//
//  MenuViewController.swift
//  NeoCafe Staff
//

import UIKit

class MenuViewController: BaseViewController<MenuViewModel, MenuView> {
    var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        //        contentView.collectionView.reloadData()
        Loader.shared.showLoader(view: self.view)
        viewModel.getCategories()
        viewModel.getMenuItems()
        setupBindings()
    }

    private func setupViews() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.allCategories.isEmpty == false && self?.viewModel.menuItems.isEmpty  == false  {
                    self?.selectFirstCategory()
                }
                self?.contentView.collectionView.reloadData()
                self?.checkIfDataLoadedThenHideLoader()
            }
        }

        viewModel.onMenuItemsFetched = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.menuItems.isEmpty  == false  && self?.viewModel.allCategories.isEmpty  == false  {
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
            Loader.shared.hideLoader(view: self.view)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MenuSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header: CollectionViewHeader = collectionView.dequeue(forHeader: indexPath)
//
//        if let sectionKind = MenuSection(rawValue: MenuSection.allCases[indexPath.section].rawValue) {
//            switch sectionKind {
//            case .category:
//                header.configureTitle(title: S.tableNo)
//            case .productItem:
//                break
//            }
//        }
//        return header
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            let category = viewModel.allCategories[indexPath.row]
            viewModel.filterMenuItems(byCategory: category)
            selectedCategoryIndex = indexPath.row
            collectionView.reloadData()

        case .productItem:
            let menuItem = viewModel.menuItems[indexPath.row]
            //            viewModel.onAddItemNavigate?(menuItem.id)
        }
    }
}
 
