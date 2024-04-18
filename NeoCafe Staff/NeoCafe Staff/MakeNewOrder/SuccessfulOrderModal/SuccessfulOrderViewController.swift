//
//  SuccessfulOrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class SuccessfulOrderViewController: UIViewController {
    private lazy var successfulOrderView = SuccessfulOrderView()
    private var successfulOrderViewModel: SuccessfulOrderViewModel

    init(viewModel: SuccessfulOrderViewModel) {
        self.successfulOrderViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = successfulOrderView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        successfulOrderView.goToOrderButton.addTarget(self, action: #selector(goToOrderButtonTapped), for: .touchUpInside)
        successfulOrderView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        successfulOrderViewModel.onBackNavigate?()
    }

    @objc func goToOrderButtonTapped() {
        successfulOrderViewModel.ongoToOrderNavigate?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
