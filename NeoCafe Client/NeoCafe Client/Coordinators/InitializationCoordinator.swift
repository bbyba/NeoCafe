//
//  OnboardingCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class InitializationCoordinator: BaseCoordinator {

    var onLoginNavigate: EmptyCompletion?

    lazy var startController: UIViewController = {
        let vm = SplashViewModelImpl()
        vm.onLoginNavigate = onLoginNavigate
        let vc = SplashViewController(viewModel: vm)
        router.setRootModule(vc, hideBar: true)
        return vc
    }()

    override var toPresent: UIViewController {
        startController
    }

    deinit {
        onLoginNavigate = nil
    }
}
