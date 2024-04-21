//
//  BonusViewController.swift
//  NeoCafe Client
//

import UIKit

class BonusViewController: BaseViewController<BonusModalViewModel, BonusModalView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.errorPresenter = self
        addTargets()
    }

    func addTargets() {
        contentView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        contentView.noButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        contentView.useButton.addTarget(self, action: #selector(useButtonTapped), for: .touchUpInside)
        contentView.cancelButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        contentView.goodButton.addTarget(self, action: #selector(goodButtonTapped), for: .touchUpInside)
    }

    @objc private func yesButtonTapped() {
        contentView.changeStateToNext()
    }

    @objc private func goodButtonTapped() {
        dismiss(animated: true, completion: nil)
        viewModel.onMainScreenNavigate?()
    }

    @objc private func dismissView(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc private func useButtonTapped() {
        if let bonusPointsText = contentView.textfield.text, let bonusPoints = Int(bonusPointsText) {
            viewModel.bonusPointsToSubtract = bonusPoints
        }
        viewModel.makeOrder()
        viewModel.orderMadeSuccessfully = {
            self.contentView.changeStateToNext()
        }
    }
}

extension BonusViewController: ErrorViewDelegate {
    func reloadLastRequest() {
        viewModel.makeOrder()
    }
}
