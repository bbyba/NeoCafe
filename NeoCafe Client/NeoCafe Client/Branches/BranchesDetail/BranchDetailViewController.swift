//
//  BranchDetailViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchDetailViewController: UIViewController {
    private lazy var branchDetailView = BranchDetailView()

    var suggestions: [PrItem] = [
        PrItem(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP3", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP4", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP5", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP6", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP7", price: 230)]

    override func loadView() {
        view = branchDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        branchDetailView.collectionView.dataSource = self
        branchDetailView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        //            baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
}

extension BranchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuProductCell.identifier, for: indexPath) as? MenuProductCell else {
                fatalError("Could not dequeue MenuProductCell")
            }
        let category = suggestions[indexPath.row]
//        cell.configureData(imageName: category.image, name: category.name, price: Int(category.price))
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as? CollectionViewSingleHeader else {
            fatalError("Could not dequeue Header")
        }
        header.configureTitle(title: S.pleasantAddition)
        return header
    }
}
