//
//  MakeNewOrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class MakeNewOrderViewController: BaseViewController<MakeNewOrderViewModel, MakeNewOrderPopup> {
    var selectedTable: TableModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self

        addTargets()
    }


//    private func updateUI() {
//        contentView.totalLabel.text = String(viewModel.totalPrice(for: selectedTable))
//    }

    private func addTargets() {
        contentView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        contentView.blurredBackgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func dismissPopup() {
        viewModel.onBackNavigate?()
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
        //        guard let selectedTable = selectedTable else { return 0 }
        return viewModel.cart.getItems().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
        let item = viewModel.cart.getItems()[indexPath.row]
        cell.configureData(item: item.item, quantity: item.quantity)
        return cell
    }
}
