//
//  ViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    private lazy var mainView = MainView()

    // TO MOVE!!!!!!!
    var categories: [Category] = [
        Category(name: "Кофе", image: Asset.Menu.coffee.name),
        Category(name: "Десерты", image: Asset.Menu.dessert.name),
        Category(name: "Выпечка", image: Asset.Menu.bakery.name),
        Category(name: "Напитки", image: Asset.Menu.drink.name),
        Category(name: "Чай", image: Asset.Menu.tea.name)
    ]

    var popularItems: [PopularItem] = [
        PopularItem(name: "POP1", image: Asset.Menu.coffee.name),
        PopularItem(name: "POP2", image: Asset.Menu.dessert.name),
        PopularItem(name: "POP3", image: Asset.Menu.bakery.name),
        PopularItem(name: "POP4", image: Asset.Menu.drink.name)]

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        mainView.collectionView.dataSource = self
    }

    private func addTargets() {
        //            baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
}
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
            //        case .header:
            //            return 0
        case .category:
            return categories.count
        case .popular:
            return popularItems.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
            //        case .header:
            //            fatalError("Header section should not request cells")
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                fatalError("Could not dequeue CategoryCell")
            }
            let category = categories[indexPath.row]
            cell.configureData(name: category.name, imageName: category.image)
            return cell
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else {
                fatalError("Could not dequeue PopularCell")
            }
            let popularItem = popularItems[indexPath.row]
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as! CollectionViewSingleHeader

        if let sectionKind = Section(rawValue: Section.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: S.ourMenu)
            case .popular:
                header.configureTitle(title: S.popular)
            }
        }
        return header
    }
}
