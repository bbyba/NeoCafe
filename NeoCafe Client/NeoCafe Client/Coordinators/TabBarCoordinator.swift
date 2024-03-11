//
//  TabBarCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {

    var mainCoordinator: MainCoordinator?
    var cartCoordinator: CartCoordinator?
    var branchesCoordinator: BranchesCoordinator?
    var profileCoordinator: ProfileCoordinator?

    private lazy var tabBarViewController = configure(CustomTabBarController()) { tabBarController in
        configureAppearance(for: tabBarController)

        let mainCoordinator = makeMainCoordinator
        self.mainCoordinator = mainCoordinator
        addChild(mainCoordinator)

        let cartCoordinator = makeCartCoordinator
        self.cartCoordinator = cartCoordinator
        addChild(cartCoordinator)

        let branchesCoordinator = makeBranchesCoordinator
        self.branchesCoordinator = branchesCoordinator
        addChild(branchesCoordinator)

        let profileCoordinator = makeProfileCoordinator
        self.profileCoordinator = profileCoordinator
        addChild(profileCoordinator)

        tabBarController.viewControllers = [
            mainCoordinator.toPresent,
            cartCoordinator.toPresent,
            branchesCoordinator.toPresent,
            profileCoordinator.toPresent
        ]

        mainCoordinator.start()
        cartCoordinator.start()
        branchesCoordinator.start()
        profileCoordinator.start()
    }

    private var makeMainCoordinator: MainCoordinator {
        let mainCoordinator = MainCoordinator(router: RouterImpl())
        mainCoordinator.tabBarCoordinator = self
        self.mainCoordinator = mainCoordinator
        return mainCoordinator
    }

    private var makeCartCoordinator: CartCoordinator {
        let cartCoordinator = CartCoordinator(router: RouterImpl())
        return cartCoordinator
    }

    private var makeBranchesCoordinator: BranchesCoordinator {
        let branchesCoordinator = BranchesCoordinator(router: RouterImpl())
//        branchesCoordinator.onCourses = fromLessons
        return branchesCoordinator
    }

    private var makeProfileCoordinator: ProfileCoordinator {
        let profileCoordinator = ProfileCoordinator(router: RouterImpl())
//        profileCoordinator.onComplete = onComplete
//        profileCoordinator.onCourses = fromLessons
        return profileCoordinator
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
        tabBarController.tabBar.tintColor = .orangeCustom
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
