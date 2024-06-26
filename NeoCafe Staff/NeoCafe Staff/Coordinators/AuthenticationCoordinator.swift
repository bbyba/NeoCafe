//
//  AuthenticationCoordinator.swift
//  NeoCafe Client
//

import UIKit
import Moya

final class AuthenticationCoordinator: BaseCoordinator {
    var emailReceived: String?
    var onMainNavigate: EmptyCompletion?

    lazy var startController: UIViewController = {
        let viewModel = AuthenticationViewModel()
        viewModel.emailReceived = { [weak self] email in
            self?.emailReceived = email
        }
        viewModel.onCodeConfirmationNavigate = { [ weak self ] in
            self?.openCodeConfirmation()
        }
        let viewController = AuthenticationViewController(viewModel: viewModel)
        router.setRootModule(viewController, hideBar: true)
        return viewController
    }()

    private func openCodeConfirmation() {
        let viewModel = CodeConfirmationViewModel()
        viewModel.onBackNavigate = { [weak self] in
            self?.router.popModule(animated: true)
        }
        viewModel.onMainNavigate = onMainNavigate
        viewModel.waiterEmail = emailReceived
        let viewController = CodeConfirmationViewController(viewModel: viewModel)
        router.push(viewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }

    override var toPresent: UIViewController {
        startController
    }

    deinit {
        onMainNavigate = nil
    }
}
