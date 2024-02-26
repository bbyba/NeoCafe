//
//  SceneDelegate.swift
//  NeoCafe Client
//
//  Created by Burte Bayaraa on 2024.02.05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.windowScene = windowScene
        window.rootViewController = MainViewController()
//        window.rootViewController = RegistrationViewController()

        window.makeKeyAndVisible()
        self.window = window
    }
}
