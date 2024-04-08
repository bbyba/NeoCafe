//
//  NewOrderViewController.swift
//  NeoCafe Staff
//

import UIKit

class NewOrderViewController: BaseViewController<NewOrderViewModel, NewOrderView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        getTables()
    }

    private func setupViews() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
    }

    private func getTables() {
        Loader.shared.showLoader(view: self.view)
        TableService.shared.getTables {
            DispatchQueue.main.async {
                Loader.shared.hideLoader(view: self.view)
                self.contentView.collectionView.reloadData()
            }
        }
    }

    private func addTargets() {
        contentView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        contentView.notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
    }

    @objc private func profileButtonTapped() {
        viewModel.onProfileNavigate?()
    }
    
    @objc private func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }
}

extension NewOrderViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TableService.shared.tables.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TablesCollectionViewCell = collectionView.dequeue(for: indexPath)
        let table = TableService.shared.tables[indexPath.row]
        cell.configureData(tableModel: table)
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let table = TableService.shared.tables[indexPath.row]
        viewModel.selectedTable = table
        viewModel.onMakeNewOrderNavigate?(table)
    }
}
