//
//  MenuViewController.swift
//  NeoCafe Client
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelectBranch(branchName: String?)
}

class MenuViewController: BaseViewController<MenuViewModel, MenuView> {
    var selectedCategoryIndex = 0
    var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        Loader.shared.showLoader(view: view)
        fetchCategoriesAndItems()
        setupBindings()
        contentView.branchNameLabel.text = UserDefaultsService.shared.branchName ?? "Select Branch"
    }

    func didSelectBranch(branchName: String?) {
        contentView.branchNameLabel.text = branchName
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func fetchCategoriesAndItems() {
        viewModel.getCategories()
        viewModel.getMenuItems()
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

    private func updateBranchLabel() {
        contentView.branchNameLabel.text = UserDefaultsService.shared.branchName
    }

    private func selectFirstCategory() {
        guard let firstCategory = viewModel.allCategories.first else { return }
        viewModel.filterMenuItems(byCategory: firstCategory)
        selectedCategoryIndex = 0
        contentView.collectionView.reloadData()
    }

    func addTargets() {
        contentView.headerDropDownButton.addTarget(self, action: #selector(menuDropdownButtonTapped), for: .touchUpInside)
    }

    @objc func menuDropdownButtonTapped() {
        viewModel.onBranchesNavigate?()
    }

    private func checkIfDataLoadedThenHideLoader() {
        if !viewModel.allCategories.isEmpty && !viewModel.menuItems.isEmpty {
            Loader.shared.hideLoader(view: view)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        MenuSection.allCases.count
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
            let cell: MenuCategoryCell = collectionView.dequeue(for: indexPath)
            let category = viewModel.allCategories[indexPath.row]
            cell.configureData(name: category.name)
            cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
            return cell

        case .productItem:
            let cell: MenuProductCell = collectionView.dequeue(for: indexPath)
            let menuItem = viewModel.filteredMenuItems[indexPath.row]
            cell.configureData(item: menuItem)
            cell.onAddToCart = { [weak self] item in
                self?.viewModel.addToCart(menuItem: item)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
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
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            let category = viewModel.allCategories[indexPath.row]
            viewModel.filterMenuItems(byCategory: category)
            selectedCategoryIndex = indexPath.row
            collectionView.reloadData()
        case .productItem:
            let menuItem = viewModel.filteredMenuItems[indexPath.row]
            viewModel.onProductDetailNavigate?(menuItem.id)
        }
    }
}
