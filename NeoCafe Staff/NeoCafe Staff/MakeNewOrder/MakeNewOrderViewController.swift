//
//  MakeNewOrderViewController.swift
//  NeoCafe Staff
//
//  Created by Burte Bayaraa on 2024.03.31.
//

import Foundation
import UIKit

class MakeNewOrderViewController: BaseViewController<MakeNewOrderViewModel, MakeNewOrderPopup> {
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self

        addTargets()
    }

    private func addTargets() {
        contentView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }

    @objc private func orderButtonTapped() {
        viewModel.onOrderNavigate?()
    }
}

extension MakeNewOrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.orderedItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
        let orderedItem = viewModel.orderedItems[indexPath.row]
        cell.configureData(item: orderedItem)
        return cell
    }
}
