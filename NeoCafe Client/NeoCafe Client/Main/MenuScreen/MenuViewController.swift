//
//  MenuViewController.swift
//  NeoCafe Client
//

import UIKit

class MenuViewController: BaseViewController<MenuViewModel, MenuView> {
    lazy var menuView = MenuView()
    var selectedCategoryIndex = 0

    var popularItems: [PrItem] = [
        PrItem(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP3", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP4", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP5", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP6", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP7", price: 230)]

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
        setTargets()

        viewModel.getAllCategories { [weak self] result in
            switch result {
            case .success(_):
                self?.menuView.collectionView.reloadData()
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }

    override func setTargets() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        menuView.headerDropDownButton.addTarget(self, action: #selector(menuDropdownButtonTapped), for: .touchUpInside)
    }

    @objc func menuDropdownButtonTapped() {
        print("MENU: branches modal dropdown tapped")
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
//            return viewModel.menuItems.count
            return popularItems.count
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
//            let productItem = viewModel.menuItems[indexPath.row]
//            cell.configureData(id: productItem.id, name: productItem.name, description: productItem.description, itemImage: productItem.itemImage, pricePerUnit: productItem.pricePerUnit, branch: productItem.branch, category: productItem.category)
            let popularItem = popularItems[indexPath.row]
            cell.configureData(id: nil, name: popularItem.name, description: nil, itemImage: popularItem.image, pricePerUnit: popularItem.price, branch: nil, category: nil)
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
//            let menuItemSquare = viewModel.menuItems[indexPath.row]
//            let productDetailViewController = ProductViewController()
//            productDetailViewController.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(productDetailViewController, animated: true)

            let menuItemSquare = popularItems[indexPath.row]
            let productDetailViewController = ProductViewController()
            productDetailViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}
