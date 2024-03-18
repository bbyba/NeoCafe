//
//  CartCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class CartCoordinator: BaseCoordinator {
    var onBonusModalsNavigate: EmptyCompletion?

    private var mainVC: CartViewController!

    override func start() {
        let viewModel = CartViewModel()
//        viewModel.onBonusModalsNavigate = { [weak self] in self?.openBonusModals()}
        let viewController = CartViewController()
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
