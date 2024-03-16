//
//  ProfileCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {

    private var mainVC: ProfileViewController!

//    override func start() {
//        let viewModel = ProfileViewModel()
//        viewModel.onEditProfileNavigate = { [weak self] in self?.openEditProfile()}
//        let viewController = ProfileViewController(viewModel: viewModel)
//        viewController.coordinator = self
//        mainVC = viewController
//        presentViewController(viewController)
//    }

    override func start() {
        let viewModel = ProfileViewModel()
        viewModel.onEditProfileNavigate = { [weak self] in self?.openEditProfile()}

        viewModel.getPersonalData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    let viewController = ProfileViewController(viewModel: viewModel)
                    viewController.coordinator = self
                    viewController.configureUserData(userData)
                    self?.presentViewController(viewController)
                case .failure(let error):
                    print("Error fetching user data: \(error)")
                }
            }
        }
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.profile
        viewController.tabBarItem.image = Asset.TabBar.profileTab.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.profileTab.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    func openEditProfile() {
        let viewModel = EditProfileViewModel()
        viewModel.onBackNavigate = { [weak self] in self?.router.popModule(animated: true)}
        let editProfileViewController = EditProfileViewController(viewModel: viewModel)
        router.push(editProfileViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }

}
