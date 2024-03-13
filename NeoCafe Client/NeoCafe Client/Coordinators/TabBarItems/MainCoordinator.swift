//
//  MainCoordinator.swift
//  NeoCafe Client
//

import UIKit
import Moya

final class MainCoordinator: BaseCoordinator {

    var onSearchNavigate: EmptyCompletion?
    private var mainVC: MainViewController!
    var tabBarCoordinator: TabBarCoordinator?

    override func start() {
        let viewModel = MainViewModel()
        viewModel.onMenuNavigate = { [weak self] in self?.openMenu(0) }
        viewModel.onNotificationsNavigate = { [weak self] in self?.openNotifications()}
        let viewController = MainViewController(viewModel: viewModel)
        mainVC = viewController
        viewController.tabBarItem.title = S.main
        viewController.tabBarItem.image = Asset.TabBar.main.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
        router.setRootModule(viewController, hideBar: false)
    }

    private func openNotifications() {
        let viewModel = NotificationsViewModel()
        viewModel.onBackNavigate = { [weak self] in self?.router.popModule(animated: true)}
        let notificationsViewController = NotificationsViewController(viewModel: viewModel)
//        router.push(notificationsViewController, hideBottomBar: false)
        router.push(notificationsViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }

    private func openMenu(_ categoryNum: Int) {
        let menuViewModel = MenuViewModel()
//        menuViewModel.onSearchNavigate = { [weak self] in self?.openSearch() }
        menuViewModel.onBranchesNavigate = { [weak self] in self?.openBranches()}
        let menuViewController = MenuViewController(viewModel: menuViewModel)
        router.push(menuViewController, hideBottomBar: false)
    }

    private func openBranches() {
//        let viewModel = mainVC.viewModel
//        viewModel.onNotificationsNavigate = { [weak self] in self?.openNotifications() }
        let branchesViewController = BranchesModalViewController()
        branchesViewController.modalPresentationStyle = .overFullScreen
        router.present(branchesViewController, animated: false)
    }

}
//
//
//import UIKit
//import Moya
//
//final class MainCoordinator: BaseCoordinator {
//
//    var onSearchNavigate: EmptyCompletion?
//    private var mainVC: MainViewController!
//    var tabBarCoordinator: TabBarCoordinator?
//
//    override func start() {
//        let viewModel = MainViewModel()
//        viewModel.onMenuNavigate = { [weak self] in self?.openMenu(0) }
//
//        let viewController = MainViewController(viewModel: viewModel)
//        mainVC = viewController
//        viewController.tabBarItem.title = S.main
//        viewController.tabBarItem.image = Asset.TabBar.main.image
//        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
//        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
//        router.setRootModule(viewController, hideBar: false)
//    }
//
//    private func openMenu(_ categoryNum: Int) {
//        let menuViewModel = MenuViewModel()
////        menuViewModel.onSearchNavigate = { [weak self] in self?.openSearch() }
//        if let categories = mainVC?.viewModel.categories {
//            menuViewModel.categories = categories
//        }
//        let menuViewController = MenuViewController(viewModel: menuViewModel)
//        router.push(menuViewController, hideBottomBar: false)
//    }
