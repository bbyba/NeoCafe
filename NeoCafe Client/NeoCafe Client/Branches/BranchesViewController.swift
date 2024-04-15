//
//  BranchesViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchesViewController: BaseViewController<BranchesViewModel, BranchesView> {
    var coordinator: BranchesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()
        getBranches()
    }

    private func addTargets() {
        //        branchesModalView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    func getBranches() {
        viewModel.getBranches { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching branches: \(error)")
                }
            }
        }
    }
}

extension BranchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBranch = viewModel.branchesList[indexPath.row]
        coordinator?.openBranchDetail(branch: selectedBranch)
//        viewModel.onBranchDetailNavigate?(selectedBranch.id)
    }
}
