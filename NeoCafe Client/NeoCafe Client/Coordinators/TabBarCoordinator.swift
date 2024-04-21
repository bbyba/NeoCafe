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
    private var tabBarShadow: UIView?

    lazy var tabBarViewController = configure(CustomTabBarController()) { tabBarController in
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
            profileCoordinator.toPresent,
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
        cartCoordinator.tabBarCoordinator = self
        return cartCoordinator
    }

    private var makeBranchesCoordinator: BranchesCoordinator {
        let branchesCoordinator = BranchesCoordinator(router: RouterImpl())
        return branchesCoordinator
    }

    private var makeProfileCoordinator: ProfileCoordinator {
        let profileCoordinator = ProfileCoordinator(router: RouterImpl())
        return profileCoordinator
    }

    override var toPresent: UIViewController {
        tabBarViewController
    }

    override init(router: Router) {
        super.init(router: router)
    }

    private func configureAppearance(for tabBarController: UITabBarController) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .clear
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .whiteCustom
        navigationBarAppearance.shadowColor = .clear
        tabBarController.tabBar.tintColor = .orangeCustom
        tabBarController.tabBar.layer.cornerRadius = 0
        tabBarController.tabBar.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white

            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
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
        true
    }
}
