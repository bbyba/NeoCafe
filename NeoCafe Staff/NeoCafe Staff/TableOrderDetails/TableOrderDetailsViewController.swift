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
        configureUI()
    }

    private func configureUI() {
        let selectedOrder = viewModel.singleOrder
        contentView.headerLabel.text = "\(S.tableNo)\(String(describing: selectedOrder.table?.tableNumber))"
        contentView.orderNumberLabel.text = "\(S.numberSymbol)\(String(describing: selectedOrder.orderNumber))"
        contentView.statusAndTimeLabel.text = "Time: \(String(describing: selectedOrder.createdAt))"
        contentView.waiterNameLabel.text = "\(S.waiter)\(String(describing: selectedOrder.employeeProfile?.username))"


//        contentView.headerLabel.text = "\(S.tableNo(selectedOrder.table.tableNumber))"
//        contentView.orderNumberLabel.text = "\(S.numberSymbol(selectedOrder.orderNumber))"
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
        return viewModel.singleOrder.ito.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
        let orderedItem = viewModel.singleOrder.ito[indexPath.row]
        cell.configureDataOrderScreen(item: orderedItem)
        return cell
    }
}
