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
    private var shouldShowBranchesFirst = true

    override func start() {
        let viewModel = MainViewModel()
        viewModel.onMenuNavigate = { [weak self] in self?.openMenu(0) }
        viewModel.onNotificationsNavigate = { [weak self] in self?.openNotifications()}
        let viewController = MainViewController(viewModel: viewModel)
        mainVC = viewController
        presentViewController(viewController)
    }

    //
    //    override func start() {
    //        let viewModel = MainViewModel()
    //        viewModel.onMenuNavigate = { [weak self] in self?.openMenu(0) }
    //        viewModel.onNotificationsNavigate = { [weak self] in self?.openNotifications()}
    //        let viewController = MainViewController(viewModel: viewModel)
    //        mainVC = viewController
    //        presentViewController(viewController)
    //    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.main
        viewController.tabBarItem.image = Asset.TabBar.main.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
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
        if shouldShowBranchesFirst {
            openBranches(initialSelection: true)
        } else {
            let menuViewController = createMenuViewController()
            router.push(menuViewController, hideBottomBar: false)
        }
    }

    private func showMenuWithBranch(branchID: Int, branchName: String) {
        let menuViewController = createMenuViewController()
        menuViewController.selectedBranchID = branchID
        menuViewController.selectedBranchName = branchName
        router.push(menuViewController, hideBottomBar: false)
    }

    private func createMenuViewController() -> MenuViewController {
        let menuViewModel = MenuViewModel()
        menuViewModel.onBranchesNavigate = { [weak self] in self?.openBranches(initialSelection: false) }
        let menuViewController = MenuViewController(viewModel: menuViewModel)
        return menuViewController
    }


    private func openBranches(initialSelection: Bool) {
        let branchesViewModel = BranchesViewModel()
        let branchesViewController = BranchesModalViewController(viewModel: branchesViewModel)
        branchesViewController.delegate = self
        branchesViewController.modalPresentationStyle = .overFullScreen
        if initialSelection {
            router.present(branchesViewController, animated: true)
        } else {
            router.present(branchesViewController, animated: true)
//            router.push(branchesViewController, hideBottomBar: false)
        }
    }

}

//extension MainCoordinator: BranchSelectionDelegate {
//    func branchDidSelect(branchID: Int, branchName: String) {
//        let menuViewController = MenuViewController(viewModel: MenuViewModel())
//        menuViewController.selectedBranchID = branchID
//        menuViewController.contentView.branchNameLabel.text = branchName
//        router.push(menuViewController, hideBottomBar: false)
//    }
//}

extension MainCoordinator: BranchSelectionDelegate {
    func branchDidSelect(branchID: Int, branchName: String) {
        shouldShowBranchesFirst = false
        let menuViewController = createMenuViewController()
        menuViewController.selectedBranchID = branchID
        menuViewController.selectedBranchName = branchName
        router.push(menuViewController, hideBottomBar: false)
    }
}
