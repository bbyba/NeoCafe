//
//  OnboardingCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class InitializationCoordinator: BaseCoordinator {

    var onLoginNavigate: EmptyCompletion?

    lazy var startController: UIViewController = {
        let viewModel = SplashViewModelImpl()
        viewModel.onLoginNavigate = onLoginNavigate
        let viewController = SplashViewController(viewModel: viewModel)
        router.setRootModule(viewController, hideBar: true)
        return viewController
    }()

    override var toPresent: UIViewController {
        startController
    }

    deinit {
        onLoginNavigate = nil
    }
}
