//
//  MenuViewController.swift
//  NeoCafe Client
//

import UIKit

class MenuViewController: BaseViewController<MenuViewModel, MenuView>, BranchSelectionDelegate {
    var selectedCategoryIndex = 0
    weak var branchDelegate: BranchSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()
        Loader.shared.showLoader(view: self.view)
        fetchMenuData()
        setupBindings()
    }

    private func selectFirstCategory() {
        guard let firstCategory = viewModel.allCategories.first else { return }
        viewModel.filterMenuItems(byCategory: firstCategory)
        selectedCategoryIndex = 0
        contentView.collectionView.reloadData()
    }

    func fetchMenuData() {
        getCategoriesMenu()
        getMenubyBranch()
    }

    func getCategoriesMenu() {
        viewModel.getAllCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching categories: \(error)")
                }
            }
        }
    }

    func getMenubyBranch() {
        viewModel.getMenuItems { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching menu vc: \(error)")
                }
            }
        }
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

    func branchDidSelect(branchID: Int, branchName: String) {
        viewModel.selectedBranchID = branchID
        viewModel.selectedBranchName = branchName
        contentView.branchNameLabel.text = viewModel.selectedBranchName?.isEmpty == false ? viewModel.selectedBranchName : "Select Branch"
    }

    func addTargets() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.headerDropDownButton.addTarget(self, action: #selector(menuDropdownButtonTapped), for: .touchUpInside)
    }

    @objc func menuDropdownButtonTapped() {
        viewModel.onBranchesNavigate?()
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
            //            return viewModel.menuItems.count
            return viewModel.filteredMenuItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            let cell: MenuCategoryCell = collectionView.dequeue(for: indexPath)
            let category = viewModel.allCategories[indexPath.row]
            cell.configureData(name: category.name)
            cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
            return cell

        case .productItem:
            let cell: MenuProductCell = collectionView.dequeue(for: indexPath)
            let menuItem = viewModel.filteredMenuItems[indexPath.row]
            //            let menuItem = viewModel.menuItems[indexPath.row]
            cell.configureData(item: menuItem)
            cell.onAddToCart = { [weak self] item in
                self?.viewModel.addToCart(menuItem: item)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = MenuSection(rawValue: MenuSection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: S.categories)
            case .productItem:
                break
            }
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at section: \(indexPath.section), row: \(indexPath.row)")
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            let category = viewModel.allCategories[indexPath.row]
            viewModel.filterMenuItems(byCategory: category)
            selectedCategoryIndex = indexPath.row
            collectionView.reloadData()
        case .productItem:
            let menuItem = viewModel.menuItems[indexPath.row]
            viewModel.onProductDetailNavigate?(menuItem.id)
        }
    }
}
