//
//  OrderHistoryViewController.swift
//  NeoCafe Client
//

import UIKit

enum OrderHistorySection: String, CaseIterable {
    case current
    case completed
}

class OrderHistoryViewController: BaseViewController<OrderHistoryViewModel, OrderHistoryView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        viewModel.setupCompleteOrdersList()
        viewModel.setupCurrentOrdersList()
        contentView.collectionView.reloadData()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }
}

extension OrderHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch OrderHistorySection.allCases[section] {
        case .current:
            return viewModel.currentOrdersList.count
        case .completed:
            return viewModel.completeOrdersList.count
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = viewModel.currentOrdersList[indexPath.row]
            cell.configureForOrderHistory(item: currentOrder, isOrderHistoryCell: true)
            return cell
        case .completed:
            let completedOrder = viewModel.completeOrdersList[indexPath.row]
            cell.configureForOrderHistory(item: completedOrder, isOrderHistoryCell: true)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {fatalError("Unexpected element kind") }
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = OrderHistorySection(rawValue: OrderHistorySection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .current:
                header.configureTitle(title: S.openOrder)
            case .completed:
                header.configureTitle(title: S.finished)
            }
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = viewModel.currentOrdersList[indexPath.row]
            let ViewModel = OrderDetailsViewModel(orderDetails: currentOrder)
            let orderDetailsViewController = OrderDetailsViewController(viewModel: ViewModel)
            orderDetailsViewController.contentView.hideElementsByStatus()
            navigationController?.pushViewController(orderDetailsViewController, animated: true)
        case .completed:
            let completedOrder = viewModel.completeOrdersList[indexPath.row]
            let ViewModel = OrderDetailsViewModel(orderDetails: completedOrder)
            ViewModel.orderDetails = viewModel.completeOrdersList[indexPath.row]
            let orderDetailsViewController = OrderDetailsViewController(viewModel: ViewModel)
            navigationController?.pushViewController(orderDetailsViewController, animated: true)
        }
    }
}
