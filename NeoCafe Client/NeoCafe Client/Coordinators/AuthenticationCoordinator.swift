//
//  AuthenticationCoordinator.swift
//  NeoCafe Client
//

import UIKit
import Moya

final class AuthenticationCoordinator: BaseCoordinator {

    var onMainNavigate: EmptyCompletion?

    lazy var startController: UIViewController = {
        let provider = MoyaProvider<UserAPI>()
        let viewModel = AuthViewModel(provider: provider)
        viewModel.onMainNavigate = onMainNavigate
        let viewController = AuthenticationViewController()
        viewController.viewModel = viewModel
        router.setRootModule(viewController, hideBar: true)
        return viewController
    }()


    override var toPresent: UIViewController {
        startController
    }

    deinit {
        onMainNavigate = nil
    }
}
