//
//  NewOrderMenuViewController.swift
//  NeoCafe Staff
//
import UIKit

class NewOrderMenuViewController: BaseViewController<NewOrderMenuViewModel, NewOrderMenuView>, CartUpdateDelegate {
    var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        Cart.shared.delegate = self
        contentView.checkForTableAvailability(tableIsAvailable: viewModel.selectedTable.isAvailable,
                                              orderInfo: viewModel.existingOrder)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Loader.shared.showLoader(view: self.view)
        setupBindings()
        viewModel.getCategories()
        viewModel.getMenuItems()
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

    func cartDidUpdate() {
        updateUI()
    }

    func updateUI() {
        contentView.orderLabel.text = S.toOrder
        contentView.amountLabel.text = "\(Cart.shared.getTotalPrice()) сом"
        contentView.orderInfoButton.isHidden = Cart.shared.items.isEmpty
    }

    private func addToCart(menuItem: Item) {
        Cart.shared.addItem(menuItem)
        updateUI()
    }

    @objc private func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc private func orderInfoButtonTapped() {
        if let existingOrder = viewModel.existingOrder {
            let selectedTable = viewModel.selectedTable
            viewModel.onMakeNewOrderPopupNavigate?(selectedTable, existingOrder)
        } else {
            let selectedTable = viewModel.selectedTable
            viewModel.onMakeNewOrderPopupNavigate?(selectedTable, nil)
        }
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
                header.configureTitle(title: S.tableNo(viewModel.selectedTable.tableNumber))
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


extension NewOrderMenuViewController: MakeNewOrderDelegate {
    func didUpdateCartInPopup() {
        print("Cart did update in NewOrderMenuViewController")
        updateUI()
    }
}
