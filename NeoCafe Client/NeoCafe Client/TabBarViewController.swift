////
////  TabBarViewController.swift
////  NeoCafe Client
////
//
//import UIKit
//
//enum TabBar: CaseIterable {
//    case Main
//    case Cart
//    case Branches
//    case Profile
//
//    var tabBarItem: UITabBarItem {
//        switch self {
//        case .Main:
//            return UITabBarItem(title: S.main, image: Asset.TabBar.main.image, selectedImage: nil)
//        case .Cart:
//            return UITabBarItem(title: S.cart, image: Asset.TabBar.cart.image, selectedImage: nil)
//        case .Branches:
//            return UITabBarItem(title: S.branches, image: Asset.TabBar.branches.image, selectedImage: nil)
//        case .Profile:
//            return UITabBarItem(title: S.profile, image: Asset.TabBar.profileTab.image, selectedImage: nil)
//        }
//    }
//
//    var viewController: UINavigationController {
//        var viewController = UINavigationController()
//        switch self {
//        case .Main:
//            viewController = UINavigationController(rootViewController: MainViewController())
//        case .Cart:
//            viewController = UINavigationController(rootViewController: CartViewController())
//        case .Branches:
//            viewController = UINavigationController(rootViewController: BranchesViewController())
//        case .Profile:
//            viewController = UINavigationController(rootViewController: ProfileViewController())
//        }
//
//        viewController.tabBarItem = tabBarItem
//        return viewController
//    }
//}
//
//
//
//class TabBarViewController: UITabBarController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTabBar()
//    }
//
//    private func setupTabBar() {
//        viewControllers = TabBar.allCases.map { $0.viewController }
//        tabBar.tintColor = .orangeCustom
//        tabBar.backgroundColor = .whiteCustom
//        tabBar.itemPositioning = .centered
//        tabBar.backgroundImage = UIImage()
//        tabBar.barStyle = .default
//    }
//}
