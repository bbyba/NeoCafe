//
//  NotificationsViewController.swift
//  NeoCafe Client
//

import UIKit

class NotificationsViewController: BaseViewController<NotificationsViewModel, NotificationView> {

    var notificationsList: [NotificationModel] = [
        NotificationModel(status: "Ваш заказ готов", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Вы закрыли счёт", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Ваш заказ оформлен", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02")]

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
        print("Notifications: clearAllButtonTapped")
        notificationsList.removeAll()
        contentView.collectionView.reloadData()
    }
}

extension NotificationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationsList.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationsCell.identifier, for: indexPath) as? NotificationsCell else {
                fatalError("Could not dequeue NotificationsCell")
            }
        let category = notificationsList[indexPath.row]
        cell.configureData(status: category.status, details: category.details, time: category.time)
        return cell
        }
}


//private lazy var notificationView = NotificationView()
//
//override func loadView() {
//    view = notificationView
//}
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    addTargets()
//}
//
//private func addTargets() {
////        branchesModalView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//}
//
//@objc func closeButtonTapped(_ sender: UIButton) {
//    dismiss(animated: true, completion: nil)
//}
