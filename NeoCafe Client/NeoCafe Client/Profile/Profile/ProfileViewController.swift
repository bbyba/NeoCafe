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

    var currentOrders: [OrderHistoryModel] = [
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "Сейчас"),
    ]

    var completedOrders: [OrderHistoryModel] = [
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "Вчера"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "17 августа"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "13 августа"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "10 августа")
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
        print("Profile: editProfileTapped")
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
        //        guard let orders = viewModel.orders else { return 0 }
        //                switch OrderHistorySection.allCases[section] {
        //                case .current:
        //                    return orders.filter { !$0.isCompleted }.count
        //                case .completed:
        //                    return orders.filter { $0.isCompleted }.count
        //                }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigProductCell.identifier, for: indexPath) as? BigProductCell else {fatalError("Could not dequeue BigProductCell")}
        
        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = currentOrders[indexPath.row]
            cell.configureData(name: currentOrder.name, imageName: currentOrder.image, description: currentOrder.description, price: currentOrder.status)
            cell.hideStepper()
            cell.hidePlusButton()
            return cell
        case .completed:
            let completedOrder = completedOrders[indexPath.row]
            cell.configureData(name: completedOrder.name, imageName: completedOrder.image, description: completedOrder.description, price: completedOrder.status)
            cell.hideStepper()
            cell.hidePlusButton()
            return cell
        }

//        guard let orders = viewModel.orders else { fatalError("Orders are not available") }
//        let filteredOrders: [Order] = orders.filter { OrderHistorySection.allCases[indexPath.section] == .current ? !$0.isCompleted : $0.isCompleted }
//
//        let order = filteredOrders[indexPath.row]
//        cell.configureData(name: order.name, imageName: order.image, description: order.description, price: order.status)
//        cell.hideStepper()
//        cell.hidePlusButton()
//        return cell
//    }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {fatalError("Unexpected element kind") }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as! CollectionViewSingleHeader

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

