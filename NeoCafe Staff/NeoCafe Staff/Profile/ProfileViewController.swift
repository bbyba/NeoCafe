//
//  ProfileViewController.swift
//  NeoCafe Staff
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel, ProfileView> {

//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            viewModel.getProfile()
//        }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func setupBindings() {
        viewModel.onProfileDataFetched = { [weak self] in
            self?.updateProfileViews()
        }
    }

    private func updateProfileViews() {
        if let profileData = viewModel.profileData {
            contentView.nameLabel.text = profileData.user.firstName
        }
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


