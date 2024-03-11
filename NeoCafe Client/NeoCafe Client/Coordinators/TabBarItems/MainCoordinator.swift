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

//    override func start() {
//        let viewModel = MainViewModel(categories: [CategoryModel], provider: MoyaProvider<UserAPI>)
////        viewModel.onSearchNavigate = { [weak self] in self?.openMenu() }
////        viewModel.onMenuNavigate = { [weak self] in self?.openMenu() }
//
//        let viewController = MainViewController(viewModel: viewModel)
//        mainVC = viewController
//        viewController.tabBarItem.title = S.main
//        viewController.tabBarItem.image = Asset.TabBar.main.image
//        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
////        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
//        router.setRootModule(viewController, hideBar: false)
//    }

    override func start() {
        let viewModel = MainViewModel()
        viewModel.onMenuNavigate = { [weak self] in self?.openMenu(0) }

        let viewController = MainViewController(viewModel: viewModel)
        mainVC = viewController
        viewController.tabBarItem.title = S.main
        viewController.tabBarItem.image = Asset.TabBar.main.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.main.image.withTintColor(.orangeCustom)
        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
        router.setRootModule(viewController, hideBar: false)
    }


//    override func start() {
//        let viewModel = MainViewModel()
////        viewModel.onSearchNavigate = { [weak self] in self?.openSearch() }
////        viewModel.onBranchList = { [weak self] in self?.openBranchModal() }
//        viewModel.onMenuNavigate = { [weak self] category in self?.openMenu(category) }
////        viewModel.onNotificationNavigate = { [weak self] in self?.openNotification()}
//    }

//    private func openSearch() {
//        let viewModel = SearchViewModel()
//        viewModel.onBackNavigate = { [weak self] in
//            self?.router.popModule(animated: true)
//        }
//        let viewController = SearchViewController(viewModel: viewModel)
//        router.push(viewController, animated: false)
//    }

    private func openMenu(_ categoryNum: Int) {
        let viewModel = MenuViewModel()
//        viewModel.onSearchNavigate = { [weak self] in self?.openSearch() }
//        viewModel.onBranches = { [weak self] in self?.openBranchModal() }
//        viewModel.onProductDetail = { [weak self] product, count in
//            self?.openProduct(with: product, and: count)
//        }
        let viewController = MenuViewController(viewModel: viewModel)
        router.push(viewController, hideBottomBar: false)

        
    }

//    private func openProduct(with product: Product,
//                             and count: Int) {
//        let viewModel = ProductDetailViewModel(with: product, and: count)
//        viewModel.toBackNavigate = { [weak self] in
//            self?.router.popModule(animated: true)
//            self?.tabBarCoordinator?.showShadowView()
//        }
//        viewModel.showModal = { [weak self] selectedProduct in
//            self?.openAdditionalModal(with: selectedProduct) }
//        let viewController = ProductDetailViewController(viewModel: viewModel)
//        router.push(viewController, hideBottomBar: true)
//        tabBarCoordinator?.hideShadowView()
//    }

//
//    private func openBranchModal() {
//        let viewModel = BranchListViewModel()
//        viewModel.onBackNavigate = { [weak self] in
//            self?.router.dismissModule(animated: true, completion: nil)
//        }
//        let viewController = BranchListViewController(viewModel: viewModel)
//        viewController.modalPresentationStyle = .overFullScreen
//        router.present(viewController, animated: false)
//    }
//
//    private func openNotification() {
//        let viewModel = NotificationViewModel()
//        viewModel.onBackNavigate = { [weak self] in
//            self?.router.popModule(animated: true)
//        }
//        let viewController = NotificationViewController(viewModel: viewModel)
//        router.push(viewController, hideBottomBar: false)
//    }
}

