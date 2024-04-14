//
//  ProfileCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = ProfileViewModel()
        viewModel.onEditProfileNavigate = { [weak self] in
            self?.openEditProfile()
        }
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.coordinator = self
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.profile
        viewController.tabBarItem.image = Asset.TabBar.profileTab.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.profileTab.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    func openEditProfile() {
        let viewModel = EditProfileViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        viewModel.onEditCompleted = { [weak self] in
            self?.start()
        }
        viewModel.getPersonalDataEdit { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    let editProfileViewController = EditProfileViewController(viewModel: viewModel)
                    viewModel.personalDataEdit = userData
                    editProfileViewController.configureData(userData)
                    self?.router.push(editProfileViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
                case .failure(let error):
                    print("Error fetching user edit data: \(error)")
                }
            }
        }
    }
}
