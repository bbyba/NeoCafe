//
//  OrderCoordinator.swift
//  NeoCafe Staff
//
import UIKit

final class OrderCoordinator: BaseCoordinator {
    var tabBarCoordinator: TabBarCoordinator?

    override func start() {
        let viewModel = OrderViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        viewModel.onOrderDetailsNavigate = { [weak self] selectedOrder in
            self?.openOrderDetails(singleOrder: selectedOrder)
        }
        let viewController = OrderViewController(viewModel: viewModel)
        presentViewController(viewController)
    }

    func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.orders
        viewController.tabBarItem.image = UIImage(systemName: "pencil.circle")
        viewController.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")
        router.setRootModule(viewController, 
                             hideBar: false)
    }

    func openProfile() {
        let viewModel = ProfileViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        //                viewModel.onLogoutNavigate = { [weak self] in
        //                    self?.router.popModule(animated: true)
        //                }
        let viewController = ProfileViewController(viewModel: viewModel)
        router.push(viewController, 
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openNotifications() {
        let viewModel = NotificationsViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = NotificationsViewController(viewModel: viewModel)
        router.push(viewController, 
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openOrderDetails(singleOrder: OrderDetailsModel) {
        let viewModel = TableOrderDetailsViewModel(orderDetails: singleOrder)
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        viewModel.onAddNavigate = { [weak self] in
            self?.openMenuToPatchExistingOrder(existingOrder: singleOrder)
        }
        let viewController = TableOrderDetailsViewController(viewModel: viewModel)
        router.push(viewController, 
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openMenuToPatchExistingOrder(existingOrder: OrderDetailsModel) {
        guard let tabBarCoordinator = self.tabBarCoordinator else {
                print("Error: tabBarCoordinator is nil.")
                return
            }
        tabBarCoordinator.newOrderCoordinator?.openMakeNewOrder(table: existingOrder.table, 
                                                                existingOrder: existingOrder)
        tabBarCoordinator.tabBarViewController.selectedIndex = 1
    }
}
