//
//  CartCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class CartCoordinator: BaseCoordinator {
    var onOrderNavigate: EmptyCompletion?

    private var mainVC: CartViewController!

    override func start() {
        let viewModel = CartViewModel()
//        viewModel.onAddMoreNavigate = { [weak self] in
//            self?.mainCoordinator?.openMenu(withBranchID: nil, branchName: nil)
//        }
        viewModel.onOrderNavigate = { [weak self] in
            self?.openBonusModals()
        }

        let viewController = CartViewController(viewModel: viewModel)
        mainVC = viewController
        viewController.tabBarItem.title = S.cart
        viewController.tabBarItem.image = Asset.TabBar.cart.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.cart.image.withTintColor(.orangeCustom)
        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
        router.setRootModule(viewController, hideBar: false)
    }

    func openBonusModals() {
//        let viewModel = BonusModalViewModel()
//        let bonusViewController = BonusViewController(viewModel: viewModel)
//        bonusViewController.modalPresentationStyle = .overFullScreen
//        router.present(bonusViewController, animated: false)
    }
}
