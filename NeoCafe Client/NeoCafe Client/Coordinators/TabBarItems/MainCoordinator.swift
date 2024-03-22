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
        viewModel.onMenuNavigate = { [weak self] in
            self?.openMenu(withBranchID: nil, branchName: nil)
        }
        viewModel.onNotificationsNavigate = { [weak self] in
            self?.openNotifications()
        }
        let viewController = MainViewController(viewModel: viewModel)
        mainVC = viewController
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.main
        viewController.tabBarItem.image = Asset.TabBar.main.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    private func openNotifications() {
        let viewModel = NotificationsViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let notificationsViewController = NotificationsViewController(viewModel: viewModel)
        router.push(notificationsViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }

    private func openMenu(withBranchID branchID: Int?, branchName: String?) {
            let menuViewController = createMenuViewController(branchID: branchID, branchName: branchName)
            router.push(menuViewController, hideBottomBar: false)
    }

    private func createMenuViewController(branchID: Int?, branchName: String?) -> MenuViewController {
        let menuViewModel = MenuViewModel()
        menuViewModel.onBranchesNavigate = { [weak self] in
            self?.openBranches(initialSelection: false)
        }
        let menuViewController = MenuViewController(viewModel: menuViewModel)
        menuViewController.selectedBranchID = branchID
        menuViewController.selectedBranchName = branchName
        return menuViewController
    }

    private func openBranches(initialSelection: Bool) {
        let branchesViewModel = BranchesModalViewModel()
        branchesViewModel.onBranchesSelectedNavigate = { [weak self] branchID, branchName in
            self?.shouldShowBranchesFirst = false
            self?.openMenu(withBranchID: branchID, branchName: branchName)
        }
        let branchesViewController = BranchesModalViewController(viewModel: branchesViewModel)
        branchesViewController.delegate = self
        branchesViewController.modalPresentationStyle = .overFullScreen
        router.present(branchesViewController, animated: true)
    }
}

extension MainCoordinator: BranchSelectionDelegate {
    func branchDidSelect(branchID: Int, branchName: String) {
        openMenu(withBranchID: branchID, branchName: branchName)
    }
}
