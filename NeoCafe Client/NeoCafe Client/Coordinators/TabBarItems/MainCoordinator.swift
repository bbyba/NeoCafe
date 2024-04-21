//
//  MainCoordinator.swift
//  NeoCafe Client
//

import Moya
import UIKit

final class MainCoordinator: BaseCoordinator {
    private var onSearchNavigate: EmptyCompletion?
    var mainViewController: MainViewController!
    var tabBarCoordinator: TabBarCoordinator?
    private var shouldShowBranchesFirst = true
    var selectedBranchID: Int? = UserDefaultsService.shared.branchID
    var selectedBranchName: String? = UserDefaultsService.shared.branchName

    override func start() {
        let viewModel = MainViewModel()
        viewModel.onMenuNavigate = { [weak self] in
            self?.openMenu(branchID: self?.selectedBranchID, branchName: self?.selectedBranchName)
        }
        viewModel.onNotificationsNavigate = { [weak self] in
            self?.openNotifications()
        }
        viewModel.onBranchesModalNavigate = { [weak self] in
            self?.openBranchesMain(initialSelection: true)
        }
        let viewController = MainViewController(viewModel: viewModel)
        mainViewController = viewController
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
        let viewController = NotificationsViewController(viewModel: viewModel)
        router.push(viewController,
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    func openMenu(branchID: Int?, branchName: String?) {
        let viewModel = MenuViewModel()
        viewModel.selectedBranchID = branchID
        viewModel.selectedBranchName = branchName
        viewModel.onBranchesNavigate = { [weak self] in
            self?.openBranchesMain(initialSelection: true)
        }
        viewModel.onProductDetailNavigate = { [weak self] productId in
            self?.openProductDetails(productId: productId)
        }
        let viewController = MenuViewController(viewModel: viewModel)
        viewController.delegate = self
        router.push(viewController,
                    animated: true,
                    hideBottomBar: false,
                    hideNavBar: true,
                    completion: nil)
    }

    private func openProductDetails(productId: Int) {
        let viewModel = ProductDetailViewModel()
        viewModel.getProductDetails(productId: productId)
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = ProductDetailViewController(viewModel: viewModel)
        viewModel.onProductDetailUpdate = { productDetail in
            viewController.configureProductData(productData: productDetail)
        }
        router.push(viewController,
                    animated: true,
                    hideBottomBar: true,
                    hideNavBar: true,
                    completion: nil)
    }

    private func openBranches() {
        let viewModel = BranchesModalViewModel()
        let viewController = BranchesModalViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        router.present(viewController, animated: true)
    }

    private func openBranchesMain(initialSelection: Bool) {
        let viewModel = BranchesModalViewModel()
        viewModel.onBranchSelectedNavigate = { [weak self] branchID, branchName in
            self?.selectedBranchID = branchID
            self?.selectedBranchName = branchName
            if initialSelection {
                DispatchQueue.main.async {
                    self?.mainViewController.selectedBranchID = branchID
                    self?.mainViewController.selectedBranchName = branchName
                    self?.mainViewController.updateForSelectedBranch()
                }
            }
        }
        let viewController = BranchesModalViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        router.present(viewController, animated: true)
    }

    func openMenu() {
        guard let tabBarViewController = tabBarCoordinator?.tabBarViewController else { return }
        tabBarViewController.selectedIndex = 0
    }
}

extension MainCoordinator: MenuViewControllerDelegate {
    func didSelectBranch(branchName: String?) {
        selectedBranchName = branchName
        mainViewController?.selectedBranchName = branchName
        mainViewController?.updateForSelectedBranch()
    }
}
