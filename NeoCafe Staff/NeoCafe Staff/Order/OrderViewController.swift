//
//  OrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class OrderViewController: BaseViewController<OrderViewModel, OrderView> {
    var selectedCategoryIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        addTargets()
        getTables()
//        viewModel.getAllOrders()
        viewModel.filterOrders(byStatus: S.all)
    }

    private func setDelegatesAndDataSource() {
        contentView.tablesCollectionView.dataSource = self
        contentView.tablesCollectionView.delegate = self
        contentView.ordersByStatusCollectionView.dataSource = self
        contentView.ordersByStatusCollectionView.delegate = self
    }

    private func getTables() {
        Loader.shared.showLoader(view: self.view)
        TableService.shared.getTables {
            DispatchQueue.main.async {
                Loader.shared.hideLoader(view: self.view)
                self.contentView.tablesCollectionView.reloadData()
            }
        }
    }

    private func addTargets() {
        contentView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        contentView.notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
        contentView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    @objc private func profileButtonTapped() {
        viewModel.onProfileNavigate?()
    }
    @objc private func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }

    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            contentView.statusStackView.isHidden = false
            contentView.tablesCollectionView.isHidden = false
            contentView.ordersByStatusCollectionView.isHidden = true
        case 1:
            contentView.tablesCollectionView.isHidden = true
            contentView.ordersByStatusCollectionView.isHidden = false
            contentView.statusStackView.isHidden = true
        default:
            break
        }
    }
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == contentView.tablesCollectionView {
            return 1
        } else if collectionView == contentView.ordersByStatusCollectionView {
            return OrderStatus.allCases.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == contentView.tablesCollectionView {
            return TableService.shared.tables.count

        } else if collectionView == contentView.ordersByStatusCollectionView {
            switch OrderStatus.allCases[section] {
            case .statusCategory:
                return viewModel.statusList.count
            case .statusOrder:
                return viewModel.filteredOrders.count
            }
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.tablesCollectionView {
            let cell: TablesCollectionViewCell = collectionView.dequeue(for: indexPath)
            let table = TableService.shared.tables[indexPath.row]
            cell.configureData(tableModel: table)
            contentView.tablesCollectionView.reloadData()
            return cell
        } else if collectionView == contentView.ordersByStatusCollectionView {
            switch OrderStatus.allCases[indexPath.section] {
            case .statusCategory:
                let cell: CategoryCell = collectionView.dequeue(for: indexPath)
                let category = viewModel.statusList[indexPath.row]
                cell.isCategorySelected = (indexPath.row == selectedCategoryIndex)
                cell.configureData(name: category)
                return cell
            case .statusOrder:
                let cell: OrdersCollectionViewCell = collectionView.dequeue(for: indexPath)
                let order = viewModel.filteredOrders[indexPath.row]
                cell.configureData(orderData: order)
                //                collectionView.reloadData()
                return cell
            }
        }
        return UICollectionViewCell(frame: .zero)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == contentView.ordersByStatusCollectionView {
            switch OrderStatus.allCases[indexPath.section] {
            case .statusCategory:
                let status = viewModel.statusList[indexPath.row]
                selectedCategoryIndex = indexPath.row
                viewModel.filterOrders(byStatus: status)
                collectionView.reloadData()
            case .statusOrder:
                let selectedOrder = viewModel.filteredOrders[indexPath.row]
                viewModel.onOrderDetailsNavigate?(selectedOrder)
            }
        }
    }
}
