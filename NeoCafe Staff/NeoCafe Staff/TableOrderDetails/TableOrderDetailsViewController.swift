//
//  TableOrderDetailsViewController.swift
//  NeoCafe Staff
//
import UIKit

class TableOrderDetailsViewController: BaseViewController<TableOrderDetailsViewModel, TableOrderDetailsView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndDataSource()
        addTargets()
        configureUI()
    }

    init(viewModel: TableOrderDetailsViewModel) {
        super.init(viewModel: viewModel)
    }

    private func setDelegatesAndDataSource() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func configureUI() {
        contentView.configureUI(orderDetail: viewModel.orderDetails)
    }

    func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func addButtonTapped() {
        viewModel.onAddNavigate?()
    }
}

extension TableOrderDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.orderDetails.ito.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomBigCell = collectionView.dequeue(for: indexPath)
        let orderedItem = viewModel.orderDetails.ito[indexPath.row]
        cell.configureDataOrderScreen(item: orderedItem)
        return cell
    }
}
