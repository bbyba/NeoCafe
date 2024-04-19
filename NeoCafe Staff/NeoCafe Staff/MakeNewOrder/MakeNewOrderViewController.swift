//
//  MakeNewOrderViewController.swift
//  NeoCafe Staff
//

import UIKit

protocol MakeNewOrderDelegate: AnyObject {
    func cartDidUpdateInMakeNewOrder()
}

class MakeNewOrderViewController: BaseViewController<MakeNewOrderViewModel, MakeNewOrderPopup> {
    weak var delegate: MakeNewOrderDelegate?
    var selectedTable: TableModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        addTargets()
        updateUI()
    }

    private func setDelegatesAndDataSource() {
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        Cart.shared.delegate = self
    }

    private func addTargets() {
        contentView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        contentView.blurredBackgroundView.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissPopup() {
        viewModel.onBackNavigate?()
    }

    @objc private func orderButtonTapped() {
        dismissPopup()
//        viewModel.handleOrder()
        viewModel.onOrderNavigate?()
    }
}

extension MakeNewOrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cart.shared.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
        let item = Cart.shared.getItems()[indexPath.row]
        cell.configureData(item: item.item, quantity: item.quantity)
        cell.onStepperValueChanged = { [weak self] newValue in
            Cart.shared.items[item.item] = newValue
            self?.cartDidUpdate()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let customCell = cell as? CustomBigCell {
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
        contentView.collectionView.deleteItems(at: [indexPath])
        cartDidUpdate()
    }
}

extension MakeNewOrderViewController: CartUpdateDelegate {
    func cartDidUpdate() {
            updateUI()
            delegate?.cartDidUpdateInMakeNewOrder()
        }

    private func updateUI() {
        updateTitleLabel()
        contentView.priceLabel.text = S.som(Cart.shared.getTotalPrice())
    }

    private func updateTitleLabel() {
        if let orderNumber = viewModel.existingOrder?.orderNumber {
            contentView.titleLabel.text = S.orderNo(orderNumber)
        } else {
            contentView.titleLabel.text = S.newOrder
        }
    }
}
