//
//  MenuCoordinator.swift
//  NeoCafe Staff
//

import UIKit
import Moya

final class MenuCoordinator: BaseCoordinator {
//
//    var onSearchNavigate: EmptyCompletion?
//    private var mainVC: MainViewController!
//    var tabBarCoordinator: TabBarCoordinator?
//    private var shouldShowBranchesFirst = true
//    private var selectedBranchID: Int?
//    private var selectedBranchName: String?
//
//    override func start() {
//        let viewModel = MainViewModel()
//        viewModel.onMenuNavigate = { [weak self] in
//            self?.openMenu(branchID: self?.selectedBranchID, branchName: self?.selectedBranchName)
//        }
//        viewModel.onNotificationsNavigate = { [weak self] in
//            self?.openNotifications()
//        }
//        viewModel.onBranchesModalNavigate = { [weak self] in
//            self?.openBranchesMain(initialSelection: true)
//        }
//        let viewController = MainViewController(viewModel: viewModel)
//        mainVC = viewController
//        presentViewController(viewController)
//    }
//
//    private func presentViewController(_ viewController: UIViewController) {
//        viewController.tabBarItem.title = S.main
//        viewController.tabBarItem.image = Asset.TabBar.main.image
//        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
//        router.setRootModule(viewController, hideBar: false)
//    }
//
//    private func openNotifications() {
//        let viewModel = NotificationsViewModel()
//        viewModel.onBackNavigate = { [weak self] in
//            self?.router.popModule(animated: true)
//        }
//        let notificationsViewController = NotificationsViewController(viewModel: viewModel)
//        router.push(notificationsViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
//    }
//
//    private func openMenu(branchID: Int?, branchName: String?) {
//        let menuViewModel = MenuViewModel()
//        menuViewModel.selectedBranchID = branchID
//        menuViewModel.selectedBranchName = branchName
//        menuViewModel.onBranchesNavigate = { [weak self] in
//            self?.openBranches()
//        }
//        let menuViewController = MenuViewController(viewModel: menuViewModel)
//        if let validBranchID = branchID, let validBranchName = branchName {
//            menuViewController.branchDidSelect(branchID: validBranchID, branchName: validBranchName)
//        }
//        router.push(menuViewController, hideBottomBar: false)
//    }
//
//    private func openBranches() {
//        let branchesViewModel = BranchesModalViewModel()
//        let branchesViewController = BranchesModalViewController(viewModel: branchesViewModel)
//        branchesViewController.delegate = self
//        branchesViewController.modalPresentationStyle = .overFullScreen
//        router.present(branchesViewController, animated: true)
//    }
//
//    private func openBranchesMain(initialSelection: Bool) {
//        let branchesViewModel = BranchesModalViewModel()
//        branchesViewModel.onBranchSelectedNavigate = { [weak self] branchID, branchName in
//            self?.selectedBranchID = branchID
//            self?.selectedBranchName = branchName
//            if initialSelection {
//                DispatchQueue.main.async {
//                    self?.mainVC.viewModel.selectedBranchID = branchID
//                    self?.mainVC.viewModel.selectedBranchName = branchName
//                    self?.mainVC.updateForSelectedBranch()
//                }
//            }
//        }
//        let branchesViewController = BranchesModalViewController(viewModel: branchesViewModel)
//        branchesViewController.delegate = self
//        branchesViewController.modalPresentationStyle = .overFullScreen
//        router.present(branchesViewController, animated: true)
//    }
}
