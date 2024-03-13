//
//  BranchesViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchesViewController: BaseViewController<BranchesViewModel, BranchesView>{

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

                    self?.viewModel.branchesList.forEach { branch in
                        print("ID: \(branch.id), Name: \(branch.branchName), Phone Number: \(branch.phoneNumber), Link 2GIS: \(branch.link2gis), Table Quantity: \(branch.tableQuantity), Image: \(String(describing: branch.image)), Description: \(branch.description)")
                        branch.schedules.forEach { schedule in
                            print("Schedule Day: \(schedule.day)")
                        }
                    }
                case .failure(let error):
//                    print("Error fetching branches: \(error)")
                                        print("Error vc failure")

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
        cell.configureData(name: branch.branchName, address: branch.address)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at section: \(indexPath.section), row: \(indexPath.row)")
        let branchDetailViewController = BranchDetailViewController()
        branchDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(branchDetailViewController, animated: true)
    }
}
