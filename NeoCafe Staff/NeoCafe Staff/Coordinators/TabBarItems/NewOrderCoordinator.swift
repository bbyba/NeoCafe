//
//  NewOrderCoordinator.swift
//  NeoCafe Staff
//

import UIKit

final class NewOrderCoordinator: BaseCoordinator {
    private var mainVC: OrderViewController!

    override func start() {
        let viewModel = OrderViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        let viewController = OrderViewController(viewModel: viewModel)
        mainVC = viewController
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.newOrder
        viewController.tabBarItem.image = UIImage(systemName: "plus.circle")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "plus.circle.fill")
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
