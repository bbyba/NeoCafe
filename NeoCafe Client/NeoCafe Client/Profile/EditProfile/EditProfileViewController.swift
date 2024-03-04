//
//  EditProfileViewController.swift
//  NeoCafe Client
//

import UIKit

class EditProfileViewController: UIViewController{
    private lazy var editProfileView = EditProfileView()

    override func loadView() {
        view = editProfileView
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
