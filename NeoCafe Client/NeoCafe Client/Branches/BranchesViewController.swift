//
//  BranchesViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchesViewController: BaseViewController<BranchesViewModel, BranchesView> {
    var coordinator: BranchesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        Loader.shared.showLoader(view: view)
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
                Loader.shared.hideLoader(view: self?.view ?? UIView())
            }
        }
    }
}

extension BranchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBranch = viewModel.branchesList[indexPath.row]
        coordinator?.openBranchDetail(branch: selectedBranch)
//        viewModel.onBranchDetailNavigate?(selectedBranch.id)
    }
}
