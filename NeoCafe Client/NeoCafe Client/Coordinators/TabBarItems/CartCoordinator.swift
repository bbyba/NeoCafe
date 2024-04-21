//
//  CartCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class CartCoordinator: BaseCoordinator {
    private var mainViewController: CartViewController!
    var tabBarCoordinator: TabBarCoordinator?

    override func start() {
        let viewModel = CartViewModel()
        viewModel.onBonusModalsNavigate = { [weak self] in
            self?.openBonusModals()
        }
        viewModel.onMainMenuNavigate = { [weak self] in
            self?.openMainMenu()
        }
        viewModel.onOrderHistoryNavigate = { [weak self] in
            self?.openOrderHistory()
        }
        let viewController = CartViewController(viewModel: viewModel)
        viewController.tabBarItem.title = S.cart
        viewController.tabBarItem.image = Asset.TabBar.cart.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.cart.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    private func openBonusModals() {
        let viewModel = BonusModalViewModel()
        viewModel.onMainScreenNavigate = { [weak self] in
            self?.openMainMenu()
        }
        let viewController = BonusViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        router.present(viewController, animated: false)
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
                    hideBottomBar: false,
                    hideNavBar: true,
                    completion: nil)
    }

    private func openMainMenu() {
        guard let tabBarCoordinator = tabBarCoordinator else { return }
        tabBarCoordinator.mainCoordinator?.openMenu(branchID: UserDefaultsService.shared.branchID,
                                                    branchName: UserDefaultsService.shared.branchName)
        tabBarCoordinator.tabBarViewController.selectedIndex = 0
    }

    private func openOrderHistory() {
        let viewModel = OrderHistoryViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        let viewController = OrderHistoryViewController(viewModel: viewModel)
        router.push(viewController,
                    animated: true,
                    hideBottomBar: false,
                    hideNavBar: true,
                    completion: nil)
    }
}
