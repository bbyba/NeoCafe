//
//  TabBarCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {

    var orderCoordinator: OrderCoordinator?
    var newOrderCoordinator: NewOrderCoordinator?
    var menuCoordinator: MenuCoordinator?

    private lazy var tabBarViewController = configure(CustomTabBarController()) { tabBarController in
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
            menuCoordinator.toPresent
        ]

        orderCoordinator.start()
        newOrderCoordinator.start()
        menuCoordinator.start()
    }

    private var makeOrderCoordinator: OrderCoordinator {
        let orderCoordinator = OrderCoordinator(router: RouterImpl())
        self.orderCoordinator = orderCoordinator
        return orderCoordinator
    }

    private var makeNewOrderCoordinator: NewOrderCoordinator {
        let newOrderCoordinator = NewOrderCoordinator(router: RouterImpl())
        return newOrderCoordinator
    }

    private var makeMenuCoordinator: MenuCoordinator {
        let menuCoordinator = MenuCoordinator(router: RouterImpl())
        //        branchesCoordinator.onCourses = fromLessons
        return menuCoordinator
    }

    override var toPresent: UIViewController {
        tabBarViewController
    }

    override init(router: Router) {
        super.init(router: router)    }

    deinit {
        //        reachability?.stopNotifier()
    }

    private func configureAppearance(for tabBarController: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .clear
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .whiteCustom
        navigationBarAppearance.shadowColor = .clear
        tabBarController.tabBar.tintColor = .blueCustom
        //        tabBarController.tabBar.unselectedItemTintColor = Colors.inputText.color
        tabBarController.tabBar.layer.cornerRadius = 0
        tabBarController.tabBar.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white

            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        }
    }
}


final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
