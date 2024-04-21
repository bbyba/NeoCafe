//
//  NotificationsViewController.swift
//  NeoCafe Staff
//

import UIKit

class NotificationsViewController: BaseViewController<NotificationsViewModel, NotificationView> {
    override func setTargets() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func clearAllButtonTapped() {
        viewModel.notificationsList.removeAll()
        contentView.collectionView.reloadData()
    }
}

extension NotificationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.notificationsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NotificationsCell = collectionView.dequeue(for: indexPath)
        let notification = viewModel.notificationsList[indexPath.row]
        cell.configureData(status: notification.status,
                           details: notification.details,
                           time: notification.time)
        return cell
    }
}
