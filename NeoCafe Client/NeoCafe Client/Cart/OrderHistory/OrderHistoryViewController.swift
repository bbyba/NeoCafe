//
//  OrderHistoryViewController.swift
//  NeoCafe Client
//


import UIKit
struct OrderHistoryModel {
    let image: String
    let name: String
    let description: String
    let status: String
}

enum OrderHistorySection: String, CaseIterable {
    case current
    case completed

}

class OrderHistoryViewController: UIViewController{
    private lazy var orderHistoryView = OrderHistoryView()


    var currentOrders: [OrderHistoryModel] = [
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "Сейчас"),
    ]

    var completedOrders: [OrderHistoryModel] = [
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "Вчера"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "17 августа"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "13 августа"),
        OrderHistoryModel(image: Asset.coffeeCupTop.name, name: "NeoCafe Dzerzhinka", description: "Латте, Капучино, Багров...", status: "10 августа")
    ]

    override func loadView() {
        view = orderHistoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        orderHistoryView.collectionView.dataSource = self
        orderHistoryView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        orderHistoryView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        print("backButtonTapped")
        self.navigationController?.popViewController(animated: true)
    }
}

extension OrderHistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else {fatalError("Could not dequeue PopularCell")}

        switch OrderHistorySection.allCases[indexPath.section] {
        case .current:
            let currentOrder = currentOrders[indexPath.row]
            cell.configureData(name: currentOrder.name, imageName: currentOrder.image, description: currentOrder.description, price: currentOrder.status)
            cell.hideStepper()
            return cell
        case .completed:
            let completedOrder = completedOrders[indexPath.row]
            cell.configureData(name: completedOrder.name, imageName: completedOrder.image, description: completedOrder.description, price: completedOrder.status)
            cell.hideStepper()
            cell.hidePlusButton()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {fatalError("Unexpected element kind") }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as! CollectionViewSingleHeader

        if let sectionKind = OrderHistorySection(rawValue: OrderHistorySection.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .current:
                header.configureTitle(title: S.openOrder)
            case .completed:
                header.configureTitle(title: S.closeOrder)
            }
        }
        return header
    }
}
