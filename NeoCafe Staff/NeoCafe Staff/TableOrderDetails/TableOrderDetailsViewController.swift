//
//  TableOrderDetailsViewController.swift
//  NeoCafe Staff
//
import UIKit

class TableOrderDetailsViewController: BaseViewController<TableOrderDetailsViewModel, TableOrderDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self

        addTargets()
    }

    func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

}

extension TableOrderDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Cart.shared.items.count
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
//        let orderedItem = viewModel.orderedItems[indexPath.row]
//        let orderedItem = Cart.shared.items[indexPath.row]
//        cell.configureData(item: orderedItem)
        return cell
        }
}
