//
//  MenuCoordinator.swift
//  NeoCafe Staff
//

import UIKit
import Moya

final class MenuCoordinator: BaseCoordinator {
    private var mainViewController: MenuViewController!

    override func start() {
        let viewModel = MenuViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        let viewController = MenuViewController(viewModel: viewModel)
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.menu
        viewController.tabBarItem.image = UIImage(systemName: "book")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "book.fill")
        router.setRootModule(viewController, hideBar: false)
    }

    func openProfile() {
        let viewModel = ProfileViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        //        viewModel.onLogoutNavigate = { [weak self] in
        //            self?.router.popModule(animated: true)
        //        }
        let viewController = ProfileViewController(viewModel: viewModel)
        router.push(viewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }

    func openNotifications() {
        let viewModel = NotificationsViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = NotificationsViewController(viewModel: viewModel)
        router.push(viewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }
}
