//
//  OrderDetailsViewController.swift
//  NeoCafe Client
//

import UIKit
struct OrderDetailsModel {
    let image: String
    let name: String
    let description: String
    let price: String
}

class OrderDetailsViewController: UIViewController{
    lazy var orderDetailsView = OrderDetailsView()

    var orderDetails: [Item] = []

    override func loadView() {
        view = orderDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        orderDetailsView.collectionView.dataSource = self
        orderDetailsView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        orderDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OrderDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderDetails.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        let order = orderDetails[indexPath.row]
        cell.configureData(item: order)
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)
        header.configureTitle(title: "Neocafe Dzerzhinka, August 1")
        return header
    }
}
