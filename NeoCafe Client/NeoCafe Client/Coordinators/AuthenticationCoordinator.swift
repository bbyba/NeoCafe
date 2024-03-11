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
        let viewModel = AuthViewModelImpl(provider: provider)
        viewModel.onMainNavigate = onMainNavigate
        let viewController = AuthenticationViewController()
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
