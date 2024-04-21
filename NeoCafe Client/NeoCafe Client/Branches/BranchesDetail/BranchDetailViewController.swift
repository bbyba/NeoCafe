//
//  BranchDetailViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchDetailViewController: BaseViewController<BranchDetailViewModel, BranchDetailView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTargets()
        configureData()
    }

    private func setupCollectionView() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.scheduleTableView.dataSource = self
        contentView.scheduleTableView.delegate = self
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.goToMenuButton.addTarget(self, action: #selector(goToMenuButtonTapped), for: .touchUpInside)
        contentView.dropDownButton.addTarget(self, action: #selector(dropDownButtonTapped), for: .touchUpInside)
    }

    private func setupBindings() {
        viewModel.onPopularItemsFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.collectionView.reloadData()
            }
        }
    }

    func configureData() {
        if let branch = viewModel.branch {
            contentView.branchNameLabel.text = branch.branchName
            contentView.branchAddressLabel.text = branch.address
            contentView.scheduleTableView.reloadData()
        }
    }

    @objc func backButtonTapped() {
        viewModel.onBackNavigate?()
    }

    @objc func goToMenuButtonTapped() {
        viewModel.onMenuNavigate?()
    }

    @objc func dropDownButtonTapped() {
        contentView.toggleScheduleTableView(hidden: !contentView.scheduleTableView.isHidden)
    }
}

extension BranchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in _: UICollectionView) -> Int {
        1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.suggestionItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MenuProductCell = collectionView.dequeue(for: indexPath)
        let suggestionItem = viewModel.suggestionItems[indexPath.row]
        cell.configureData(item: suggestionItem)
        cell.onAddToCart = { [weak self] item in
            self?.viewModel.addToCart(menuItem: item)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind _: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: CollectionViewSingleHeader = collectionView.dequeue(forHeader: indexPath)
        header.configureTitle(title: S.pleasantAddition)
        return header
    }
}

// MARK: - Schedule

extension BranchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        7
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        22
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell else {
            fatalError("Unable to dequeue ScheduleTableViewCell")
        }
        cell.selectionStyle = .none
        if let schedule = viewModel.branch?.schedules[indexPath.row] {
            let scheduleString = "\(schedule.day): \(schedule.startTime) - \(schedule.endTime)"
            cell.workingHours.text = scheduleString
        }
        return cell
    }
}
