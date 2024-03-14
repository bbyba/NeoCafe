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

                    self?.viewModel.branchesList.forEach { branch in
                        print("Branch ID: \(branch.id), Name: \(branch.branchName), Address: \(branch.address)")
                        branch.schedules.forEach { schedule in
                            print("Schedule Day: \(schedule.day), Start Time: \(schedule.startTime), End Time: \(schedule.endTime)")
                        }
                    }
                case .failure(let error):
                    print("\(error)")
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchesModalCell.identifier, for: indexPath) as? BranchesModalCell else {
            fatalError("Could not dequeue PopularCell")
        }
        let branch = viewModel.branchesList[indexPath.row]
        cell.configureData(branch)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBranch = viewModel.branchesList[indexPath.row]
        coordinator?.openBranchDetail(branch: selectedBranch)
    }

}
