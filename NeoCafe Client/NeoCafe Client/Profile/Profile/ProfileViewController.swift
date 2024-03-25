//
//  ProfileViewController.swift
//  NeoCafe Client
//
//  

import Foundation
import UIKit
import SwiftUI

class ProfileViewController: BaseViewController<ProfileViewModel, ProfileView> {
    var coordinator: ProfileCoordinator?

    var currentOrders: [Item] = [
    ]

    var completedOrders: [Item] = [
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()
//        getUserData()
    }

    private func addTargets() {
        contentView.editButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
    }

    func configureUserData(_ userData: CustomerProfile) {
        contentView.nameLabel.text = userData.firstName
        contentView.totalBonusPointsNumber.text = String(userData.bonusPoints)
    }

    @objc func editProfileTapped() {
        viewModel.onEditProfileNavigate?()
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch OrderHistorySection.allCases[section] {
        case .current:
            return currentOrders.count
        case .completed:
            return completedOrders.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = currentOrders[indexPath.row]
            cell.configureData(item: currentOrder)
//            cell.hideStepper()
//            cell.hidePlusButton()
            return cell
        case .completed:
            let completedOrder = completedOrders[indexPath.row]
            cell.configureData(item: completedOrder)
//            cell.hideStepper()
//            cell.hidePlusButton()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {fatalError("Unexpected element kind") }
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)

        if let sectionKind = OrderHistorySection(rawValue: OrderHistorySection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .current:
                header.configureTitle(title: S.currentOrder)
            case .completed:
                header.configureTitle(title: S.finished)
            }
        }
        return header
    }
}

