//
//  NotificationsViewController.swift
//  NeoCafe Client
//

import UIKit

struct NotificationModel {
    let status: String
    let details: String
    let time: String
}

class NotificationsViewController: BaseViewController<NotificationsViewModel, NotificationView>{
    var suggestions: [NotificationModel] = [
        NotificationModel(status: "Ваш заказ готов", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Вы закрыли счёт", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02"),
        NotificationModel(status: "Ваш заказ оформлен", details: "Капучино x1, Американо x2, Багровай заКапучино x1, Американо x2, Багровай за...", time: "19:02")]

    override func setTargets() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }
}

extension NotificationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationsCell.identifier, for: indexPath) as? NotificationsCell else {
                fatalError("Could not dequeue NotificationsCell")
            }
        let category = suggestions[indexPath.row]
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
