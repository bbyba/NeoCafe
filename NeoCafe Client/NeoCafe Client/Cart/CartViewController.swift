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

    @objc func cartUpdated() {
        updateTotalPriceLabel()
        contentView.collectionView.reloadData()
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cart.shared.orderList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BigProductCell = collectionView.dequeue(for: indexPath)
        let item = Cart.shared.getItems()[indexPath.row]
        let selectedItem = item.item
        cell.configureData(item: selectedItem, quantity: item.quantity)

        cell.onStepperValueChanged = { [weak self, weak cell] newValue in
            guard let self = self, let cell = cell else { return }
            cell.updatePriceLabel(newValue: newValue, item: selectedItem)
            updateTotalPriceLabel()
        }

        cell.stepper.incrementTapped = { [weak self, weak cell] in
            guard let self = self, let cell = cell else { return }
            Cart.shared.orderList[selectedItem, default: 0] += 1
            cell.updatePriceLabel(newValue: cell.stepper.currentValue, item: selectedItem)
            updateTotalPriceLabel()
        }

        cell.stepper.decrementTapped = { [weak self, weak cell] in
            guard let self = self, let cell = cell else { return }
            if let currentQuantity = Cart.shared.orderList[selectedItem], currentQuantity > 0 {
                Cart.shared.orderList[selectedItem] = currentQuantity - 1
                cell.updatePriceLabel(newValue: cell.stepper.currentValue, item: selectedItem)
                updateTotalPriceLabel()
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let customCell = cell as? BigProductCell {
            customCell.onSwipeToDelete = { [weak self] indexPath in
                self?.showDeleteConfirmationModal(at: indexPath)
            }
        }
    }

    private func showDeleteConfirmationModal(at indexPath: IndexPath) {
        let modalViewController = DeleteModalViewController()
        modalViewController.indexPathToDelete = indexPath
        let itemToRemove = Cart.shared.getItems()[indexPath.row].item
        modalViewController.itemName = itemToRemove.name
        modalViewController.performDeletion = { [weak self] in
            self?.deleteItem(itemToRemove: itemToRemove, at: indexPath)
        }
        present(modalViewController, animated: true, completion: nil)
    }

    private func deleteItem(itemToRemove: Item, at indexPath: IndexPath) {
        Cart.shared.removeItem(itemToRemove)
        updateViewBasedOnCartState()
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
    }
}
