//
//  AuthenticationCoordinator.swift
//  NeoCafe Client
//

import UIKit
import Moya

final class AuthenticationCoordinator: BaseCoordinator {

    var onMainNavigate: EmptyCompletion?

//    lazy var startController: UIViewController = {
//        let vm = AuthViewModelImpl()
//        vm.onMainNavigate = onMainNavigate
//        let vc = AuthenticationViewController(viewModel: vm)
//        router.setRootModule(vc, hideBar: true)
//        return vc
//    }()
    lazy var startController: UIViewController = {
        let provider = MoyaProvider<UserAPI>()
        let vm = AuthViewModelImpl(provider: provider)
        vm.onMainNavigate = onMainNavigate
        let vc = AuthenticationViewController()
        router.setRootModule(vc, hideBar: true)
        return vc
    }()


    override var toPresent: UIViewController {
        startController
    }

    deinit {
        onMainNavigate = nil
    }
}
