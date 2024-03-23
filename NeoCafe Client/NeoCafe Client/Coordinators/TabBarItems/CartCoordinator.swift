//
//  CartCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class CartCoordinator: BaseCoordinator {
    private var mainVC: CartViewController!

    override func start() {
        let viewModel = CartViewModel()
        viewModel.onOrderNavigate = { [weak self] in
            self?.openBonusModals()
        }
        let viewController = CartViewController(viewModel: viewModel)
//        mainVC = viewController
        viewController.tabBarItem.title = S.cart
        viewController.tabBarItem.image = Asset.TabBar.cart.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.cart.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    func openBonusModals() {
//        let viewModel = BonusModalViewModel()
//        let bonusViewController = BonusViewController(viewModel: viewModel)
//        bonusViewController.modalPresentationStyle = .overFullScreen
//        router.present(bonusViewController, animated: false)
    }
}
