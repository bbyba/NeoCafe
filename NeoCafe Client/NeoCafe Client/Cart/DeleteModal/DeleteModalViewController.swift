//
//  DeleteModalViewController.swift
//  NeoCafe Client
//

import UIKit

class DeleteModalViewController: UIViewController {
    var indexPathToDelete: IndexPath?
    var performDeletion: (() -> Void)?
    var itemName: String = ""

    lazy var deleteModalView = DeleteModalView(frame: UIScreen.main.bounds, itemName: itemName)

    override func loadView() {
        view = deleteModalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    func addTargets() {
        deleteModalView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        deleteModalView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }

    @objc func yesButtonTapped() {
        performDeletion?()
        dismiss(animated: true, completion: nil)
    }

    @objc func noButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
