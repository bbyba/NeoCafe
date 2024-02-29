//
//  BranchesModalViewController.swift
//  NeoCafe Client
//

import UIKit
struct BranchesModel {
    let image: String
    let name: String
}

class BranchesModalViewController: UIViewController{
    private lazy var branchesModalView = BranchesModalView()

    var branches: [BranchesModel] = [
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 1"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 2"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 3"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 4"),
        BranchesModel(image: Asset.branchesModal.name, name: "NeoCafe Dzerzhinka 5"),
    ]

    override func loadView() {
        view = branchesModalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        branchesModalView.collectionView.dataSource = self
        branchesModalView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        branchesModalView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
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
}
