//
//  EditProfileViewController.swift
//  NeoCafe Client
//

import UIKit

class EditProfileViewController: BaseViewController<EditProfileViewModel, EditProfileView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        print("EditProfile: backButtonTapped")
        viewModel.onBackNavigate?()
    }

//    func configureData() {
//        if let branch = viewModel.branch {
//            contentView.branchNameLabel.text = branch.branchName
//            contentView.branchAddressLabel.text = branch.address
//        }
//    }
}
