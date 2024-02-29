//
//  ProductViewController.swift
//  NeoCafe Client
//
import UIKit

class ProductViewController: UIViewController {
    private lazy var productView = ProductView()

    var suggestions: [PrItem] = [
        PrItem(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP3", price: 230)]

    override func loadView() {
        view = productView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productView.collectionView.dataSource = self
        productView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        //            baseAuthRegView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else {
                fatalError("Could not dequeue PopularCell")
            }
        let category = suggestions[indexPath.row]
        cell.configureData(name: category.name, imageName: category.image)
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
