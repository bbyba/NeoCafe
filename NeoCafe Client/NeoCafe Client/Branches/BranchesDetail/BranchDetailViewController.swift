//
//  BranchDetailViewController.swift
//  NeoCafe Client
//

import UIKit

class BranchDetailViewController: BaseViewController<BranchDetailViewModel, BranchDetailView> {

    var suggestions: [PrItem] = [
        PrItem(image: Asset.coffeeCupTop.name, name: "POP1", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP2", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP3", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP4", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP5", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP6", price: 230),
        PrItem(image: Asset.coffeeCupTop.name, name: "POP7", price: 230)]

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.scheduleTableView.dataSource = self
        contentView.scheduleTableView.delegate = self

        addTargets()
        configureData()
    }

    private func addTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        contentView.goToMenuButton.addTarget(self, action: #selector(goToMenuButtonTapped), for: .touchUpInside)

    }

    func configureData() {
        if let branch = viewModel.branch {
            contentView.branchNameLabel.text = branch.branchName
            contentView.branchAddressLabel.text = branch.address
            contentView.scheduleTableView.reloadData()
            //            contentView.collectionView.reloadData()
        }
    }

    @objc func backButtonTapped() {
        print("branchDetail: backButtonTapped")
        viewModel.onBackNavigate?()
    }

    @objc func goToMenuButtonTapped() {
        print("branchDetail: goToMenuButton")
        viewModel.onMenuNavigate?()
    }
}

extension BranchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Suggestions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuProductCell.identifier, for: indexPath) as? MenuProductCell else {
                fatalError("Could not dequeue MenuProductCell")
            }
        let category = suggestions[indexPath.row]
//        cell.configureData(imageName: category.image, name: category.name, price: Int(category.price))
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as? CollectionViewSingleHeader else {
            fatalError("Could not dequeue Header")
        }
        header.configureTitle(title: S.pleasantAddition)
        return header
    }
}

// MARK: - Schedule
extension BranchDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 22
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell else {
            fatalError("Unable to dequeue ScheduleTableViewCell")
        }
        cell.selectionStyle = .none
        if let schedule = viewModel.branch?.schedules[indexPath.row] {
            let scheduleString = "\(schedule.day): \(schedule.startTime.dropLast(3)) - \(schedule.endTime.dropLast(3))"
//            let scheduleString = "\(schedule.day): \(branch.todaySchedule)"
            cell.workingHours.text = scheduleString
        }
        return cell
    }
}
