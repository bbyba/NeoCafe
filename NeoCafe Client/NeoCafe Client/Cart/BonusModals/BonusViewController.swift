//
//  BonusViewController.swift
//  NeoCafe Client
//

import UIKit

class BonusViewController: BaseViewController<BonusModalViewModel, BonusModalView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    func addTargets() {
        contentView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        contentView.noButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        contentView.useButton.addTarget(self, action: #selector(useButtonTapped), for: .touchUpInside)
        contentView.cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        contentView.goodButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }

    @objc private func yesButtonTapped() {
        contentView.changeStateToNext()
    }

    @objc private func useButtonTapped() {
        contentView.changeStateToNext()
    }

    @objc private func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
