//
//  SceneDelegate.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator = applicationCoordinator

        applicationCoordinator.start()
    }

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    var applicationCoordinator: TabBarCoordinator?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = scene as? UIWindowScene else { return }
//        let window = UIWindow(windowScene: windowScene)
//        self.window = window
//        let router = RouterImpl(navigationController: UINavigationController())
//        let applicationCoordinator = TabBarCoordinator(router: router)
//        self.applicationCoordinator = applicationCoordinator
//        applicationCoordinator.start()
//        window.rootViewController = applicationCoordinator.toPresent
//        window.makeKeyAndVisible()
//    }
}
