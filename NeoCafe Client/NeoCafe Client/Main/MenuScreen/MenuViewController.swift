//
//  MenuViewController.swift
//  NeoCafe Client
//

import UIKit

class MenuViewController: BaseViewController<MenuViewModel, MenuView> {
    lazy var menuView = MenuView()
    var selectedCategoryIndex = 1

    override func loadView() {
        view = menuView
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        menuView.collectionView.dataSource = self
//        menuView.collectionView.delegate = self
//        self.navigationItem.hidesBackButton = true
//        addTargets()
//        let initialIndexPath = IndexPath(item: selectedCategoryIndex, section: Int(MenuSection.category.rawValue) ?? 0)
//            menuView.collectionView.selectItem(at: initialIndexPath, animated: false, scrollPosition: [])
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.collectionView.dataSource = self
        menuView.collectionView.delegate = self
        self.navigationItem.hidesBackButton = true
        addTargets()

        if viewModel.categories.isEmpty {
            viewModel.getCategories { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self?.menuView.collectionView.reloadData()
                    case .failure(let error):
                        print("Error fetching categories: \(error)")
                    }
                }
            }
        } else {
            self.menuView.collectionView.reloadData()
        }
    }

    private func addTargets() {
        //            baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        menuView.headerDropDownButton.addTarget(self, action: #selector(menuDropdownButtonTapped), for: .touchUpInside)
    }

    @objc func menuDropdownButtonTapped() {
        let branchesModalViewController = BranchesModalViewController()
        branchesModalViewController.modalPresentationStyle = .formSheet
        branchesModalViewController.modalTransitionStyle = .crossDissolve
        present(branchesModalViewController, animated: true, completion: nil)
    }

}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MenuSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MenuSection.allCases[section] {
        case .category:
            return viewModel.categories.count
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
            let category = viewModel.categories[indexPath.row]
            cell.configureData(name: category.name)
            cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
            return cell

        case .productItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuProductCell.identifier, for: indexPath) as? MenuProductCell else {
                fatalError("Could not dequeue MenuProductCell")
            }
            let productItem = viewModel.menuItems[indexPath.row]
            cell.configureData(id: productItem.id, name: productItem.name, description: productItem.description, itemImage: productItem.itemImage, pricePerUnit: productItem.pricePerUnit, branch: productItem.branch, category: productItem.category)
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
            let menuItemSquare = viewModel.menuItems[indexPath.row]
            let productDetailViewController = ProductViewController()
            productDetailViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}
