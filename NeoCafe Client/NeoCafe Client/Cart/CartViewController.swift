//
//  CartViewController.swift
//  NeoCafe Client
//

import UIKit

class CartViewController: BaseViewController<CartViewModel, CartView> {
    private lazy var cartView = CartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        updateViewBasedOnCartState()
        updateTotalPriceLabel()
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewBasedOnCartState()
        updateTotalPriceLabel()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func addTargets() {
        contentView.orderHistoryButton.addTarget(self, action: #selector(orderHistoryButtonTapped), for: .touchUpInside)
        contentView.addMoreButton.addTarget(self, action: #selector(addMoreButtonTapped), for: .touchUpInside)
        contentView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }

    private func updateViewBasedOnCartState() {
        contentView.switchCartViews(cartEmpty: Cart.shared.orderList.isEmpty)
    }

    private func updateTotalPriceLabel() {
        let totalPrice = Cart.shared.getTotalPrice()
        contentView.priceLabel.text = S.som(totalPrice)
    }

    func reloadCollectionView() {
        contentView.collectionView.reloadData()
        updateViewBasedOnCartState()
        updateTotalPriceLabel()
    }

    @objc func cartUpdated() {
        contentView.collectionView.reloadData()
        updateTotalPriceLabel()
    }

    @objc func orderHistoryButtonTapped() {
        viewModel.onOrderHistoryNavigate?()
    }

    @objc func addMoreButtonTapped() {
        viewModel.onMainMenuNavigate?()
    }

    @objc func orderButtonTapped() {
        viewModel.onBonusModalsNavigate?()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        Cart.shared.orderList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        let item = Cart.shared.getItems()[indexPath.row]
        let selectedItem = item.item
        cell.configureData(item: selectedItem, quantity: item.quantity)

        cell.onStepperValueChanged = { [weak self] newValue in
            Cart.shared.orderList[item.item] = newValue
            cell.updatePriceLabel(newValue: newValue, item: selectedItem)
            self?.updateTotalPriceLabel()
        }

        cell.stepper.incrementTapped = { [weak self] in
            Cart.shared.orderList[selectedItem, default: 0] += 1
            cell.updatePriceLabel(newValue: cell.stepper.currentValue, item: selectedItem)
            self?.updateTotalPriceLabel()
        }

        cell.stepper.decrementTapped = { [weak self] in
            if let currentQuantity = Cart.shared.orderList[selectedItem], currentQuantity > 0 {
                Cart.shared.orderList[selectedItem] = currentQuantity - 1
                cell.updatePriceLabel(newValue: cell.stepper.currentValue, item: selectedItem)
                self?.updateTotalPriceLabel()
            }
        }
        return cell
    }

    func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let customCell = cell as? BigProductCell {
            customCell.onSwipeToDelete = { [weak self] indexPath in
                self?.showDeleteConfirmationModal(at: indexPath)
            }
        }
    }

    private func showDeleteConfirmationModal(at indexPath: IndexPath) {
        let modalViewController = DeleteModalViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        modalViewController.indexPathToDelete = indexPath
        let itemToRemove = Cart.shared.getItems()[indexPath.row].item
        modalViewController.itemName = itemToRemove.name
        modalViewController.performDeletion = { [weak self] in
            self?.deleteItem(itemToRemove: itemToRemove, at: indexPath)
        }
        present(modalViewController, animated: true, completion: nil)
    }

    private func deleteItem(itemToRemove: Item, at _: IndexPath) {
        Cart.shared.removeItem(itemToRemove)
        updateTotalPriceLabel()
        contentView.collectionView.reloadData()
        updateViewBasedOnCartState()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
