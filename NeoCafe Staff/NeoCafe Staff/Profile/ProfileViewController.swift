//
//  ProfileViewController.swift
//  NeoCafe Staff
//

import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel, ProfileView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.nameTextField.isUserInteractionEnabled = false
        addTargets()
        setupBindings()

        Loader.shared.showLoader(view: self.view)
        viewModel.getProfile()
    }

    private func setupBindings() {
        viewModel.onProfileDataFetched = { [weak self] in
            DispatchQueue.main.async {
                Loader.shared.hideLoader(view: self?.view ?? UIView())
                self?.updateProfileViews()
            }
        }
    }

    private func updateProfileViews() {
        if let profileData = viewModel.profileData {
            contentView.nameTextField.text = profileData.user.firstName
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


