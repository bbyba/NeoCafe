//
//  NewOrderMenuViewController.swift
//  NeoCafe Staff
//

import UIKit

class NewOrderMenuViewController: BaseViewController<NewOrderMenuViewModel, NewOrderMenuView> {
    var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()
        contentView.collectionView.reloadData()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func backButtonTapped() {
        viewModel.onBackNavigate?()
    }
}

extension NewOrderMenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
            cell.configureData(menuItem: menuItem, newOrderView: true)
            //            cell.onAddToCart = { [weak self] item in
            //                self?.viewModel.addToCart(menuItem: item)
            //            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = MenuSection(rawValue: MenuSection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: S.tableNo)
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
            //            viewModel.onAddItemNavigate?(menuItem.id)
            if menuItem.category.name == "Кофе" {
                openCoffeeModal(for: menuItem)
            }
        }
    }

    // Temporary
    private func openCoffeeModal(for item: Item) {
        let coffeeModalVC = CoffeeDetailsViewController(viewModel: CoffeeDetailsViewModel())
        coffeeModalVC.modalPresentationStyle = .overFullScreen
        present(coffeeModalVC, animated: true, completion: nil)
    }
}
