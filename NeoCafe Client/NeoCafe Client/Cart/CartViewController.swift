//
//  CartViewController.swift
//  NeoCafe Client
//


import UIKit
struct productModel {
    let image: String
    let name: String
    let price: Int
}

class CartViewController: UIViewController{
    private lazy var cartView = CartView()
    private lazy var emptyCartView = EmptyCartView()


    var orderedProducts: [productModel] = [
        productModel(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        productModel(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        productModel(image: Asset.coffeeCupTop.name, name: "POP3", price: 230),
        productModel(image: Asset.coffeeCupTop.name, name: "POP4", price: 230),
        productModel(image: Asset.coffeeCupTop.name, name: "POP5", price: 230),
    ]

    override func loadView() {
        view = cartView
//        view = emptyCartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.collectionView.dataSource = self
        cartView.collectionView.delegate = self
        addTargets()
    }

    private func addTargets() {
        cartView.orderHistoryButton.addTarget(self, action: #selector(orderHistoryButtonTapped), for: .touchUpInside)
    }

    @objc func addMoreButtonTapped() {
        print("Cart: addMoreButtonTapped")
//        navigationController?.pushViewController(MenuViewController(), animated: true)
    }

    @objc func orderHistoryButtonTapped() {
        print("Cart: orderHistoryButtonTapped")
        print("Navigation controller: \(String(describing: navigationController))")
        navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
    }

    @objc func orderButtonTapped() {
        print("Cart: orderButtonTapped")
        navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
    }


}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderedProducts.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigProductCell.identifier, for: indexPath) as? BigProductCell else {
                fatalError("Could not dequeue BigProductCell")
            }
        let product = orderedProducts[indexPath.row]
        cell.configureData(name: product.name, imageName: product.image, description: "nil", price: String(product.price))
        cell.hideStepper()
        return cell
        }
}
