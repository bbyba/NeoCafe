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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        Loader.shared.showLoader(view: view)
        viewModel.getPersonalData()
        viewModel.fetchOrderHistory()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onPersonalDataFetched = { [weak self] personalData in
            self?.configureUserData(personalData)
        }

        viewModel.onOrdersFetched = {
            DispatchQueue.main.async {
                self.contentView.collectionView.reloadData()
                Loader.shared.hideLoader(view: self.view ?? UIView())
            }
        }
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func addTargets() {
        contentView.editButton.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        contentView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    func configureUserData(_ userData: CustomerProfile) {
        contentView.nameLabel.text = userData.firstName
        contentView.totalBonusPointsNumber.text = String(userData.bonusPoints)
    }

    @objc func editProfileTapped() {
        viewModel.onEditProfileNavigate?()
    }

    @objc func logoutButtonTapped() {
        viewModel.onLogoutButtonTapped?()
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch OrderHistorySection.allCases[section] {
        case .current:
            return viewModel.currentOrdersList.count
        case .completed:
            return viewModel.completeOrdersList.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = viewModel.currentOrdersList[indexPath.row]
            cell.configureForOrderHistory(item: currentOrder, isOrderHistoryCell: true, inCurrent: true)
            cell.descriptionLabel.text = viewModel.makeITONameList(orderIto: currentOrder.ito)
            return cell
        case .completed:
            let completedOrder = viewModel.completeOrdersList[indexPath.row]
            cell.configureForOrderHistory(item: completedOrder, isOrderHistoryCell: true, inCurrent: false)
            cell.descriptionLabel.text = viewModel.makeITONameList(orderIto: completedOrder.ito)
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

