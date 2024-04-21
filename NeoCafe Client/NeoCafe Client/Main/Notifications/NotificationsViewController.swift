//
//  NotificationsViewController.swift
//  NeoCafe Client
//

import UIKit

class NotificationsViewController: BaseViewController<NotificationsViewModel, NotificationView> {
    override func setTargets() {
        contentView.notificationsCollectionView.delegate = self
        contentView.notificationsCollectionView.dataSource = self
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func clearAllButtonTapped() {
        viewModel.notificationsList.removeAll()
        contentView.notificationsCollectionView.reloadData()
    }
}

extension NotificationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.notificationsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NotificationsCell = collectionView.dequeue(for: indexPath)
        let category = viewModel.notificationsList[indexPath.row]
        cell.configureData(status: category.status, details: category.details, time: category.time)
        return cell
    }
}
