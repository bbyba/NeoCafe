//
//  NewOrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class NewOrderViewController: BaseViewController<NewOrderViewModel, NewOrderView> {
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self

        addTargets()
    }

    private func addTargets() {
        contentView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        contentView.notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
    }

    @objc private func profileButtonTapped() {
        viewModel.onProfileNavigate?()
    }
    @objc private func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }
}

extension NewOrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tables.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TablesCollectionViewCell = collectionView.dequeue(for: indexPath)
        let table = viewModel.tables[indexPath.row]
        cell.configureData(tableNum: table.tableNumber, isBusy: table.isBusy)
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let table = viewModel.tables[indexPath.row]
        viewModel.onMakeNewOrderNavigate?()
    }
}
