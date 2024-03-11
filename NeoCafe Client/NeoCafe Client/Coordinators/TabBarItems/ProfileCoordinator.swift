//
//  ProfileCoordinator.swift
//  NeoCafe Client
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {

    //    var onCourses: EmptyCompletion?
    //
        private var mainVC: ProfileViewController!

        override func start() {
            //        let viewModel = MainViewModelImpl()
            //        viewModel.navigateToCourses = onCourses
            //        viewModel.openLessonDetail = { [weak self] in self?.openLessonDetail() }
            //        let viewController = LessonsScreenViewController(viewModel: viewModel)
            let viewController = ProfileViewController()
            mainVC = viewController
            viewController.tabBarItem.title = S.profile
            viewController.tabBarItem.image = Asset.TabBar.profileTab.image
            viewController.tabBarItem.selectedImage = Asset.TabBar.profileTab.image.withTintColor(.orangeCustom)
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
