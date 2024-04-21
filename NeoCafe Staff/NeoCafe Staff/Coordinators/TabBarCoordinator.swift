//
//  TabBarCoordinator.swift
//  NeoCafe Client
//

import SnapKit
import UIKit

final class TabBarCoordinator: BaseCoordinator {
    var orderCoordinator: OrderCoordinator?
    var newOrderCoordinator: NewOrderCoordinator?
    var menuCoordinator: MenuCoordinator?
    private var tabBarShadow: UIView?

    lazy var tabBarViewController = configure(CustomTabBarController()) { tabBarController in
        configureAppearance(for: tabBarController)

        let orderCoordinator = makeOrderCoordinator
        self.orderCoordinator = orderCoordinator
        addChild(orderCoordinator)

        let newOrderCoordinator = makeNewOrderCoordinator
        self.newOrderCoordinator = newOrderCoordinator
        addChild(newOrderCoordinator)

        let menuCoordinator = makeMenuCoordinator
        self.menuCoordinator = menuCoordinator
        addChild(menuCoordinator)

        tabBarController.viewControllers = [
            orderCoordinator.toPresent,
            newOrderCoordinator.toPresent,
            menuCoordinator.toPresent,
        ]

        orderCoordinator.start()
        newOrderCoordinator.start()
        menuCoordinator.start()
    }

    private var makeOrderCoordinator: OrderCoordinator {
        let orderCoordinator = OrderCoordinator(router: RouterImpl())
        orderCoordinator.tabBarCoordinator = self
        self.orderCoordinator = orderCoordinator
        return orderCoordinator
    }

    private var makeNewOrderCoordinator: NewOrderCoordinator {
        let newOrderCoordinator = NewOrderCoordinator(router: RouterImpl())
        newOrderCoordinator.tabBarCoordinator = self
        self.newOrderCoordinator = newOrderCoordinator
        return newOrderCoordinator
    }

    private var makeMenuCoordinator: MenuCoordinator {
        let menuCoordinator = MenuCoordinator(router: RouterImpl())
        return menuCoordinator
    }

    override var toPresent: UIViewController {
        tabBarViewController
    }

    override init(router: Router) {
        super.init(router: router)
    }

    private func configureAppearance(for tabBarController: UITabBarController) {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.stackedLayoutAppearance.normal.iconColor = .darkGreyCustom
            appearance.stackedLayoutAppearance.selected.iconColor = .blueCustom
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGreyCustom]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.blueCustom]
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.shadowColor = .clear
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBarController.tabBar.barTintColor = .white
            tabBarController.tabBar.isTranslucent = true
        }
        configureShadow(for: tabBarController)
    }

    private func configureShadow(for tabBarController: UITabBarController) {
        tabBarShadow?.removeFromSuperview()
        tabBarShadow = UIView(frame: CGRect(x: 0,
                                            y: 0,
                                            width: tabBarController.tabBar.bounds.width,
                                            height: tabBarController.tabBar.bounds.height))
        tabBarShadow!.backgroundColor = .white
        tabBarShadow!.layer.cornerRadius = 20
        tabBarShadow!.layer.masksToBounds = false
        tabBarShadow!.layer.shadowColor = UIColor.black.cgColor
        tabBarShadow!.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBarShadow!.layer.shadowOpacity = 0.1
        tabBarShadow!.layer.shadowRadius = 5

        tabBarController.tabBar.insertSubview(tabBarShadow!, at: 0)
        tabBarShadow!.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(tabBarController.tabBar)
            make.height.equalTo(tabBarController.tabBar.snp.height)
        }
    }
}

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func tabBarController(_: UITabBarController,
                          shouldSelect _: UIViewController) -> Bool
    {
        return true
    }
}
