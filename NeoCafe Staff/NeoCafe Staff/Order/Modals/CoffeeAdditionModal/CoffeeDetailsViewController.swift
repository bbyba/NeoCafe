//
//  CoffeeDetailsViewController.swift
//  NeoCafe Staff
//

import UIKit

class CoffeeDetailsViewController: BaseViewController<CoffeeDetailsViewModel, CoffeeDetailsModal> {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }

    @objc private func saveButtonTapped() {
        viewModel.onSaveNavigate?()
    }
}
