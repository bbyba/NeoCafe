//
//  BranchesModalViewController.swift
//  NeoCafe Client
//

import UIKit

protocol BranchSelectionDelegate: AnyObject {
    func branchDidSelect(branchID: Int, branchName: String)
}

class BranchesModalViewController: BaseViewController<BranchesModalViewModel, BranchesModalView>{

    weak var delegate: BranchSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        setTargets()
        fetchBranchesData()
    }

    func fetchBranchesData() {
        viewModel.getBranches { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let branches):
                    self?.viewModel.branchesList = branches
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching branches: \(error)")
                }
            }
        }
    }

    override func setTargets() {
        contentView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    @objc func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension BranchesModalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.branchesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BranchesModalCell = collectionView.dequeue(for: indexPath)
        let branch = viewModel.branchesList[indexPath.row]
        cell.configureData(branch)
        cell.hideAddressPhone()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBranch = viewModel.branchesList[indexPath.row]
        delegate?.branchDidSelect(branchID: selectedBranch.id, branchName: selectedBranch.branchName)
        dismiss(animated: true, completion: nil)
    }
}
