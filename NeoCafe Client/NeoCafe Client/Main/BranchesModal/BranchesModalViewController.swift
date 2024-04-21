//
//  BranchesModalViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchesModalViewController: BaseViewController<BranchesModalViewModel, BranchesModalView> {
    weak var delegate: MenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        viewModel.getBranches()
        setupBindings()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func setupBindings() {
        viewModel.onBranchesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.collectionView.reloadData()
            }
        }
    }

    private func addTargets() {
        contentView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    @objc func closeButtonTapped(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension BranchesModalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.branchesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BranchesModalCell = collectionView.dequeue(for: indexPath)
        let branch = viewModel.branchesList[indexPath.row]
        cell.configureData(branch)
        cell.hideAddressPhone()
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBranch = viewModel.branchesList[indexPath.row]
        viewModel.branchDidSelect(branchID: selectedBranch.id, branchName: selectedBranch.branchName)
        delegate?.didSelectBranch(branchName: selectedBranch.branchName)
        print("\(selectedBranch.branchName)")
        dismiss(animated: true, completion: nil)
    }
}
