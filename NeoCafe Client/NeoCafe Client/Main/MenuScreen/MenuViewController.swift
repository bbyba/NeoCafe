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
        setTargets()
        fetchMenuData()
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
        guard let branchID = viewModel.selectedBranchID else { return }
        viewModel.getMenuItemsByBranchCategory(branchID: branchID) { [weak self] result in
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

    func branchDidSelect(branchID: Int, branchName: String) {
        viewModel.selectedBranchID = branchID
        viewModel.selectedBranchName = branchName
        contentView.branchNameLabel.text = viewModel.selectedBranchName?.isEmpty == false ? viewModel.selectedBranchName : "Select Branch"
    }

    override func setTargets() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.headerDropDownButton.addTarget(self, action: #selector(menuDropdownButtonTapped), for: .touchUpInside)
    }

    @objc func menuDropdownButtonTapped() {
        viewModel.onBranchesNavigate?()
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
            return viewModel.menuItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoryCell.identifier, for: indexPath) as? MenuCategoryCell else {
                fatalError("Could not dequeue MenuCategoryCell")
            }
            let category = viewModel.allCategories[indexPath.row]
            cell.configureData(name: category.name)
            cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
            return cell

        case .productItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuProductCell.identifier, for: indexPath) as? MenuProductCell else {
                fatalError("Could not dequeue MenuProductCell")
            }
            let menuItem = viewModel.menuItems[indexPath.row]
            cell.configureData(item: menuItem)
            cell.onAddToCart = { [weak self] item in
                self?.viewModel.addToCart(menuItem: item)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as? CollectionViewSingleHeader else {
            fatalError("Could not dequeue Header")
        }

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
            guard let cell = collectionView.cellForItem(at: indexPath) as? MenuCategoryCell else { return }
            for visibleCell in collectionView.visibleCells {
                if let categoryCell = visibleCell as? MenuCategoryCell {
                    categoryCell.isCategorySelected = false
                }
            }
            cell.isCategorySelected = true
        case .productItem:
            let menuItem = viewModel.menuItems[indexPath.row]
            viewModel.onProductDetailNavigate?(menuItem.id)
        }
    }
}
