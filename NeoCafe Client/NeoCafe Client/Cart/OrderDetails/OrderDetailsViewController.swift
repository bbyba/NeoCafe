//
//  OrderDetailsViewController.swift
//  NeoCafe Client
//

import UIKit

class OrderDetailsViewController: BaseViewController<OrderDetailsViewModel, OrderDetailsView> {

    var orderDetails: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupCollectionView()
        addTargets()
        viewModel.fetchProductDetails {
            DispatchQueue.main.async {
                self.contentView.collectionView.reloadData()
            }
        }
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
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
        self.navigationController?.popViewController(animated: true)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemDetails.count
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
