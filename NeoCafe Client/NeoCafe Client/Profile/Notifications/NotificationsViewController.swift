//
//  NotificationsViewController.swift
//  NeoCafe Client
//

import UIKit

class NotificationsViewController: UIViewController{
    private lazy var notificationView = NotificationView()

    override func loadView() {
        view = notificationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
//        branchesModalView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    @objc func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
