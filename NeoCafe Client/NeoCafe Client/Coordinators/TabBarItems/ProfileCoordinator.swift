//
//  ProfileCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {

    private var mainVC: ProfileViewController!

    override func start() {
        let viewModel = ProfileViewModel()
        viewModel.onEditProfileNavigate = { [weak self] in self?.openEditProfile()}
        let viewController = ProfileViewController(viewModel: viewModel)
        viewController.coordinator = self
        mainVC = viewController
        viewController.tabBarItem.title = S.profile
        viewController.tabBarItem.image = Asset.TabBar.profileTab.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.profileTab.image.withTintColor(.orangeCustom)
        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
        router.setRootModule(viewController, hideBar: false)
    }

    func openEditProfile() {
        let viewModel = EditProfileViewModel()
        //        viewModel.branch = branch
        viewModel.onBackNavigate = { [weak self] in self?.router.popModule(animated: true)}
        let editProfileViewController = EditProfileViewController(viewModel: viewModel)
        router.push(editProfileViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }
}
