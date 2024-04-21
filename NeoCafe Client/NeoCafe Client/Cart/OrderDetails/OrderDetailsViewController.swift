//
//  OrderDetailsViewController.swift
//  NeoCafe Client
//

import UIKit

class OrderDetailsViewController: BaseViewController<OrderDetailsViewModel, OrderDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        Loader.shared.showLoader(view: view)
        configureUI()
        setupBindings()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.fetchProductDetails {
            DispatchQueue.main.async {
                Loader.shared.hideLoader(view: self.view)
                self.contentView.collectionView.reloadData()
            }
        }
    }

    private func configureUI() {
        contentView.headerLabel.text = S.orderHash(viewModel.orderDetails.orderNumber)
        contentView.branchLabel.text = "\(viewModel.orderDetails.branchName), "
        contentView.dateLabel.text = viewModel.orderDetails.createdAt
        contentView.totalAvailablePoints.text = String(viewModel.orderDetails.bonusPointsToSubtract)
        contentView.priceLabel.text = String(viewModel.orderDetails.totalSum)
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc func orderButtonTapped() {
        Cart.shared.removeAllItems()
        for item in viewModel.itemDetails {
            Cart.shared.addItem(item)
        }
        viewModel.onCartNavigate?()
    }
}

extension OrderDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.itemDetails.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        cell.stepper.decrementButton.isUserInteractionEnabled = false
        cell.stepper.incrementButton.isUserInteractionEnabled = false
        let order = viewModel.itemDetails[indexPath.row]
        if let ito = viewModel.orderDetails.ito.first(where: { $0.item == order.id }) {
            cell.configureData(item: order, quantity: ito.quantity)
        }
        return cell
    }
}
