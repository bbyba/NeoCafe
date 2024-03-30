//
//  NewOrderCoordinator.swift
//  NeoCafe Staff
//

import UIKit

final class NewOrderCoordinator: BaseCoordinator {
    private var mainVC: NewOrderViewController!

    override func start() {
        let viewModel = NewOrderViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        viewModel.onMakeNewOrderNavigate = { [ weak self ] in
            self?.openMakeNewOrder()
        }
        let viewController = NewOrderViewController(viewModel: viewModel)
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

    func openMakeNewOrder() {
        let viewModel = NewOrderMenuViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = NewOrderMenuViewController(viewModel: viewModel)
        router.push(viewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }
}
