//
//  ProfileViewController.swift
//  NeoCafe Staff
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel, ProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func logoutButtonTapped() {
        viewModel.onLogoutNavigate?()
    }
}


