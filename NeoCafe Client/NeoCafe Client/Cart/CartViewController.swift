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

class CartViewController: BaseViewController<CartViewModel, CartView> {

    private lazy var emptyCartView = EmptyCartView()
    private lazy var cartView = CartView()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = CartViewModel.shared.orderList.isEmpty ? emptyCartView : cartView
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        addTargets()

        NotificationCenter.default.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdated, object: nil)
    }

    private func updateCartView() {
        DispatchQueue.main.async { [weak self] in
            let shouldShowEmptyView = CartViewModel.shared.orderList.isEmpty
            self?.view = shouldShowEmptyView ? self?.emptyCartView : self?.cartView
            if !shouldShowEmptyView {
                self?.cartView.collectionView.dataSource = self
                self?.cartView.collectionView.delegate = self
                self?.cartView.collectionView.reloadData()
                self?.updateTotalPrice()
            }
        }
    }


    private func updateTotalPrice() {
        let totalPriceString = "\(CartViewModel.shared.calculateTotalPrice()) с"
        if view == cartView {
            cartView.priceLabel.text = totalPriceString
        }
    }

    private func addTargets() {
        contentView.orderHistoryButton.addTarget(self, action: #selector(orderHistoryButtonTapped), for: .touchUpInside)
    }

    @objc private func handleCartUpdate() {
        DispatchQueue.main.async {
            self.contentView.collectionView.reloadData()
            self.updateCartView()
            self.updateTotalPrice()
        }
    }

    @objc func addMoreButtonTapped() {
        print("Cart: addMoreButtonTapped")
        //        navigationController?.pushViewController(MenuViewController(), animated: true)
    }

    @objc func orderHistoryButtonTapped() {
        print("Cart: orderHistoryButtonTapped")
        //        navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
    }

    @objc func orderButtonTapped() {
        print("Cart: orderButtonTapped")
        //        navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CartViewModel.shared.orderList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        let item = CartViewModel.shared.orderList[indexPath.row]
        cell.configureData(item: item)
        cell.configureForCart()

        let itemQuantity = CartViewModel.shared.itemQuantities[item.id] ?? 1
        cell.stepper.currentValue = itemQuantity
        let totalPrice = item.pricePerUnit * itemQuantity
        cell.priceLabel.text = "\(totalPrice) с"

        cell.onStepperValueChanged = { [weak self] newValue in
            let updatedTotalPrice = item.pricePerUnit * newValue
            cell.priceLabel.text = "\(updatedTotalPrice) с"
            CartViewModel.shared.itemQuantities[item.id] = newValue
            self?.updateTotalPrice()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath)
                        -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let strongSelf = self else { return }

            let itemToRemove = CartViewModel.shared.orderList[indexPath.row]
            CartViewModel.shared.remove(item: itemToRemove)
            strongSelf.updateCartView()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
