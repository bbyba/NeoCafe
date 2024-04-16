//
//  NewOrderMenuViewController.swift
//  NeoCafe Staff
//

import UIKit

class NewOrderMenuViewController: BaseViewController<NewOrderMenuViewModel, NewOrderMenuView> {
    var selectedCategoryIndex = 0
    var selectedTable: TableModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        Loader.shared.showLoader(view: self.view)
        viewModel.getCategories()
        viewModel.getMenuItems()
        setupBindings()
        contentView.updateOrderNoInfo(orderNumber: 1)
        contentView.updateAmountInfo(orderAmount: 180)
    }

    private func setupViews() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.onCategoriesFetched = { [weak self] in
            DispatchQueue.main.async {
                if self?.viewModel.allCategories.isEmpty == false && self?.viewModel.menuItems.isEmpty == false{
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
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.orderInfoButton.addTarget(self, action: #selector(orderInfoButtonTapped), for: .touchUpInside)
    }

    private func addToCart(menuItem: Item) {
        guard let selectedTable = selectedTable else { return }
        let cart = viewModel.separateCartsForTables[selectedTable]
        cart?.addItem(menuItem)
    }

    @objc private func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc private func orderInfoButtonTapped() {
        print("orderInfoButtonTapped")
        guard let selectedTable = selectedTable else { return }
        viewModel.onMakeNewOrderNavigate?()

    }

    private func checkIfDataLoadedThenHideLoader() {
        if !viewModel.allCategories.isEmpty && !viewModel.menuItems.isEmpty {
            Loader.shared.hideLoader(view: self.view)
        }
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
            cell.onAddToCart = { [weak self] in
                self?.addToCart(menuItem: menuItem)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = MenuSection(rawValue: MenuSection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: "\(viewModel.tableInfo())")
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
            let menuItem = viewModel.menuItems[indexPath.row]
            //            viewModel.onAddItemNavigate?(menuItem.id)
            guard let selectedTable = selectedTable else { return }
            let cart = viewModel.createCart(for: selectedTable)
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
