//
//  BranchesCoordinator.swift
//  NeoCafe Client
//
import UIKit

final class BranchesCoordinator: BaseCoordinator {

    //    var onCourses: EmptyCompletion?
    //
    private var mainVC: BranchesViewController!

    override func start() {
        let viewModel = BranchesViewModel()
        let viewController = BranchesViewController(viewModel: viewModel)
        viewController.coordinator = self
        mainVC = viewController
        presentViewController(viewController)
    }

    private func presentViewController(_ viewController: UIViewController) {
        viewController.tabBarItem.title = S.branches
        viewController.tabBarItem.image = Asset.TabBar.branches.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.branches.image.withTintColor(.orangeCustom)
        router.setRootModule(viewController, hideBar: false)
    }

    func openBranchDetail(branch: BranchModel) {
        let viewModel = BranchDetailViewModel()
        viewModel.branch = branch
        viewModel.onBackNavigate = { [weak self] in self?.router.popModule(animated: true)}
        let branchDetailViewController = BranchDetailViewController(viewModel: viewModel)
        router.push(branchDetailViewController, animated: true, hideBottomBar: true, hideNavBar: true, completion: nil)
    }
}
