//
//  ErrorViewController.swift
//  NeoCafe Client
//

import UIKit

class ErrorViewController: BaseViewController <ErrorViewModel, ErrorView> {
    weak var delegate: ErrorViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    private func addTargets() {
        contentView.reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }

    @objc private func reloadButtonTapped() {
        reloadLastRequest()
    }
}

extension ErrorViewController: ErrorViewDelegate {
    func reloadLastRequest() {
        delegate?.reloadLastRequest()
        dismiss(animated: true, completion: nil)
    }
}
