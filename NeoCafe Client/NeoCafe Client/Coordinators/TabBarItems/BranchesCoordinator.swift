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
        //        viewModel.navigateToCourses = onCourses
        //        viewModel.openLessonDetail = { [weak self] in self?.openLessonDetail() }
        //        let viewController = LessonsScreenViewController(viewModel: viewModel)
        let viewController = BranchesViewController(viewModel: viewModel)
        mainVC = viewController
        viewController.tabBarItem.title = S.branches
        viewController.tabBarItem.image = Asset.TabBar.branches.image
        viewController.tabBarItem.selectedImage = Asset.TabBar.branches.image.withTintColor(.orangeCustom)
        //        viewController.tabBarItem.image = Asset.TabBar.main.image.withTintColor(Colors.green.color)
        router.setRootModule(viewController, hideBar: false)
    }

    //    func openLessonDetail() {
    //        let vm = LessonDetailScreenViewModel()
    //        vm.openLessonTasks = { [weak self] in self?.openLessonTaskDetail() }
    //        let vc = LessonDetailScreenViewController(viewModel: vm)
    //        router.push(vc, hideBottomBar: true)
    //    }
    //
    //    func openLessonTaskDetail() {
    //        let vm = LessonTaskViewModel()
    //        let vc = LessonTaskViewController(viewModel: vm)
    //        router.push(vc, hideBottomBar: true)
    //    }
}
