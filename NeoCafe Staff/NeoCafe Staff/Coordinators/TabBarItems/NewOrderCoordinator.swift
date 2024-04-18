//
//  NewOrderCoordinator.swift
//  NeoCafe Staff
//

import UIKit

final class NewOrderCoordinator: BaseCoordinator {
    private var mainViewController: NewOrderViewController!
    var tabBarCoordinator: TabBarCoordinator?

    override func start() {
        let viewModel = NewOrderViewModel()
        viewModel.onProfileNavigate = { [ weak self ] in
            self?.openProfile()
        }
        viewModel.onNotificationsNavigate = { [ weak self ] in
            self?.openNotifications()
        }
        viewModel.onMakeNewOrderNavigate = { [weak self] table in
            self?.openMakeNewOrder(table: table)
        }
        let viewController = NewOrderViewController(viewModel: viewModel)
        mainViewController = viewController
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
                    hideNavBar:true,
                    completion: nil)
    }

    func openMakeNewOrder(table: TableModel, existingOrder: OrderDetailsModel? = nil) {
        let viewModel = NewOrderMenuViewModel(selectedTable: table, existingOrder: existingOrder)
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        viewModel.onMakeNewOrderPopupNavigate = { [weak self] table, existingOrder in
            self?.openMakeNewOrderPopup(table: table, existingOrder: existingOrder)
        }
        let viewController = NewOrderMenuViewController(viewModel: viewModel)
        router.push(viewController, 
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openMakeNewOrderPopup(table: TableModel, existingOrder: OrderDetailsModel?) {
        let viewModel = MakeNewOrderViewModel(table: table, existingOrder: existingOrder)
        viewModel.onBackNavigate = { [weak self] in
            self?.router.dismissModule(animated: true, completion: nil)
        }
        viewModel.onOrderNavigate = { [weak self] in
            self?.openSuccesfulOrder()
        }
        let viewController = MakeNewOrderViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        router.present(viewController)
    }

    func openSuccesfulOrder() {
        let viewModel = SuccessfulOrderViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        viewModel.ongoToOrderNavigate = { [weak self] in
            self?.openOrderView()
        }
        let viewController = SuccessfulOrderViewController(viewModel: viewModel)
        router.push(viewController, 
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openOrderView() {
        guard let tabBarCoordinator = self.tabBarCoordinator else { return }
        tabBarCoordinator.removeChild(self)
        let orderCoordinator = OrderCoordinator(router: RouterImpl())
        tabBarCoordinator.addChild(orderCoordinator)
        tabBarCoordinator.tabBarViewController.selectedIndex = 0
    }

}
