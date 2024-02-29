//
//  MenuViewController.swift
//  NeoCafe Client
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate {
    private lazy var menuView = MenuView()

    var categories: [Categories] = [
        Categories(name: "Кофе"),
        Categories(name: "Десерты"),
        Categories(name: "Выпечка"),
        Categories(name: "Напитки"),
        Categories(name: "Чай")
    ]

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

    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.collectionView.dataSource = self
        menuView.collectionView.delegate = self
        addTargets()
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

extension MenuViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MenuSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MenuSection.allCases[section] {
            //        case .header:
            //            return 0
        case .category:
            return categories.count
        case .productItem:
            return popularItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MenuSection.allCases[indexPath.section] {
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoryCell.identifier, for: indexPath) as? MenuCategoryCell else {
                fatalError("Could not dequeue MenuCategoryCell")
            }
            let category = categories[indexPath.row]
            cell.configureData(name: category.name)
            return cell
        case .productItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuProductCell.identifier, for: indexPath) as? MenuProductCell else {
                fatalError("Could not dequeue MenuProductCell")
            }
            let popularItem = popularItems[indexPath.row]
            cell.configureData(imageName: popularItem.image, name: popularItem.name, price: popularItem.price)
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
}
