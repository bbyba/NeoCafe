//
//  OrderCoordinator.swift
//  NeoCafe Staff
//
import UIKit

final class OrderCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = OrderViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        viewModel.onOrderDetailsNavigate = { [ weak self ] in
            self?.openOrderDetails()
        }
        let viewController = OrderViewController(viewModel: viewModel)
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.orders
        viewController.tabBarItem.image = UIImage(systemName: "pencil.circle")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
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

    func openOrderDetails() {
        let viewModel = TableOrderDetailsViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = TableOrderDetailsViewController(viewModel: viewModel)
        router.push(viewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }
}
