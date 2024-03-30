//
//  OrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class OrderViewController: BaseViewController<OrderViewModel, OrderView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.tablesCollectionView.dataSource = self
        contentView.tablesCollectionView.delegate = self
        contentView.ordersByStatusCollectionView.dataSource = self
        contentView.ordersByStatusCollectionView.delegate = self

        addTargets()
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
            return viewModel.tables.count
        } else if collectionView == contentView.ordersByStatusCollectionView {
            switch OrderStatus.allCases[section] {
            case .statusCategory:
                return viewModel.categories.count
            case .statusOrder:
                return viewModel.ordersList.count
            }
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == contentView.tablesCollectionView {
            let cell: TablesCollectionViewCell = collectionView.dequeue(for: indexPath)
            let table = viewModel.tables[indexPath.row]
            cell.configureData(tableNum: table.tableNumber, isBusy: table.isBusy)
            return cell
        } else if collectionView == contentView.ordersByStatusCollectionView {
            switch OrderStatus.allCases[indexPath.section] {
            case .statusCategory:
                let cell: CategoryCell = collectionView.dequeue(for: indexPath)
                let category = viewModel.categories[indexPath.row]
                cell.configureData(name: category)
                return cell
            case .statusOrder:
                let cell: OrdersCollectionViewCell = collectionView.dequeue(for: indexPath)
                let order = viewModel.ordersList[indexPath.row]
                cell.configureData(orderData: order)
                return cell
            }
        }
        return UICollectionViewCell(frame: .zero)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == contentView.tablesCollectionView {
            let table = viewModel.tables[indexPath.row]
            viewModel.onOrderDetailsNavigate?()
        } else if collectionView == contentView.ordersByStatusCollectionView {
            print("Item selected at section: \(indexPath.section), row: \(indexPath.row)")
            switch OrderStatus.allCases[indexPath.section] {
            case .statusCategory:
                guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell else { return }
                for visibleCell in collectionView.visibleCells {
                    if let categoryCell = visibleCell as? CategoryCell {
                        categoryCell.isCategorySelected = false
                    }
                }
                cell.isCategorySelected = true
            case .statusOrder:
                let singleOrder = viewModel.ordersList[indexPath.row]
                viewModel.onOrderDetailsNavigate?()
            }
        }
    }

}
