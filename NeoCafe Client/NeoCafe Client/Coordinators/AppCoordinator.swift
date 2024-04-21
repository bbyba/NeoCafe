//
//  AppCoordinator.swift
//  NeoCafe Client
//

import UIKit

typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

final class ApplicationCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow, router: Router = RouterImpl()) {
        self.window = window
        super.init(router: router)
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }

    override func start() {
        performInitializationFlow()
    }

    func performInitializationFlow(completion: EmptyCompletion? = nil) {
        let coordinator = InitializationCoordinator(router: router)
        addChild(coordinator)
        coordinator.start()
        coordinator.onLoginNavigate = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            self?.performLoginFlow()
            completion?()
        }
        router.setRootModule(coordinator, hideBar: true)
    }

    func performLoginFlow() {
        let coordinator = AuthenticationCoordinator(router: router)
        coordinator.onMainNavigate = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            self?.performMainFlow()
        }
        addChild(coordinator)
        coordinator.start()
        router.setRootModule(coordinator, hideBar: false)
    }

    func performMainFlow() {
        let coordinator = TabBarCoordinator(router: router)
        coordinator.onComplete = { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
//            self?.performInitializationFlow()
        }
        addChild(coordinator)
        coordinator.start()
        router.setRootModule(coordinator, hideBar: true)
    }

    private func setupColors() {
        window.tintColor = .white
    }
}
