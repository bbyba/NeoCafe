//
//  SplashViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI

class SplashViewController: UIViewController {
    private lazy var splashScreenView = SplashView()

    override func loadView() {
        view = splashScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToMainViewController()
    }

    private func navigateToMainViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let mainViewController = RegistrationViewController()

            if let window = self.view.window {
                window.rootViewController = mainViewController
                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {}, completion: nil)
            }
        }
    }
}
