//
//  BranchesViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchesViewController: UIViewController{
    private lazy var branchesView = BranchesView()

    var branches: [BranchesModel] = [
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 1"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 2"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 3"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 4"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 5"),
    ]

    override func loadView() {
        view = branchesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        branchesView.collectionView.dataSource = self
        branchesView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
//        branchesModalView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

extension BranchesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return branches.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchesModalCell.identifier, for: indexPath) as? BranchesModalCell else {
                fatalError("Could not dequeue PopularCell")
            }
        let branch = branches[indexPath.row]
        cell.configureData(name: branch.name, imageName: branch.image)
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at section: \(indexPath.section), row: \(indexPath.row)")
        let branchDetailViewController = BranchDetailViewController()
        branchDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(branchDetailViewController, animated: true)
    }
}
