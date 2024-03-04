//
//  SceneDelegate.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit



//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    lazy var applicationCoordinator = ApplicationCoordinator()
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.overrideUserInterfaceStyle = .light
//
//        applicationCoordinator.start()
//    }
//}

//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    var applicationCoordinator: ApplicationCoordinator?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = scene as? UIWindowScene else { return }
//        let window = UIWindow(windowScene: windowScene)
//        self.window = window
//
//        let applicationCoordinator = ApplicationCoordinator(window: window)
//        self.applicationCoordinator = applicationCoordinator
//
//        applicationCoordinator.start()
//    }
//}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.windowScene = windowScene
//        window.rootViewController = TabBarViewController()
        window.rootViewController = EditProfileViewController()

        window.makeKeyAndVisible()
        self.window = window
    }
}
