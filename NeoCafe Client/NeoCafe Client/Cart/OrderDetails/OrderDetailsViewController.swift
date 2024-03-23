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
        print("Order details: backButtonTapped")
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigProductCell.identifier, for: indexPath) as? BigProductCell else {
                fatalError("Could not dequeue BigProductCell")
            }
        let order = orderDetails[indexPath.row]
        cell.configureData(item: order)
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as? CollectionViewSingleHeader else {
            fatalError("Could not dequeue Header")
        }
        header.configureTitle(title: "Neocafe Dzerzhinka, August 1")
        return header
    }
}
