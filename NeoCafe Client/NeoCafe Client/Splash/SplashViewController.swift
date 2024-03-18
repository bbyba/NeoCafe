//
//  SplashViewController.swift
//  NeoCafe Client
//

import UIKit

class SplashViewController: UIViewController {
    private lazy var splashScreenView = SplashView()
    private var splashViewModel: SplashViewModel

    init(viewModel: SplashViewModel) {
        self.splashViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = splashScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        splashViewModel.toLoginNavigate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
