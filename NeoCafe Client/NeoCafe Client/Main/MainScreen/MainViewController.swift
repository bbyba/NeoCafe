//
//  ViewController.swift
//  NeoCafe Client
//

import UIKit
import SwiftUI

class MainViewController: BaseViewController<MainViewModel, MainView>, UICollectionViewDelegate {
    var loadingIndicator: UIActivityIndicatorView?
    var selectedBranchName: String?
    var selectedBranchID: Int? {
        didSet {
            getCategories()
            getPopularItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        setTargets()
        viewModel.onBranchesModalNavigate?()
    }

    override func setTargets() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        contentView.notificationButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
    }

    func updateForSelectedBranch() {
        getCategories()
        getPopularItems()
    }

    func getCategories() {
        viewModel.getCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.loadingIndicator?.stopAnimating()
                    self?.contentView.collectionView.isHidden = false
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    self?.loadingIndicator?.stopAnimating()
                    print("Error fetching categories: \(error)")
                }
            }
        }
    }

    func getPopularItems() {
        guard let branchID = viewModel.selectedBranchID else { return }
        viewModel.getPopularItems(branchID: branchID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    self?.viewModel.popularItems = items
                    self?.contentView.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching popular items: \(error)")
                }
            }
        }
    }

    @objc func notificationsButtonTapped() {
        viewModel.onNotificationsNavigate?()
    }

    @objc func goToMenuTapped() {
        viewModel.onMenuNavigate?()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .category:
            return viewModel.categories.count
        case .popular:
            return min(viewModel.popularItems.count, 3)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section.allCases[indexPath.section] {
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
                fatalError("Could not dequeue CategoryCell")
            }
            let category = viewModel.categories[indexPath.row]
            cell.configureData(name: category.name, imageName: category.image!)
            return cell
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigProductCell.identifier, for: indexPath) as? BigProductCell else {
                fatalError("Could not dequeue BigProductCell")
            }
            let popularItem = viewModel.popularItems[indexPath.row]
            cell.configureData(item: popularItem)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSingleHeader.identifier, for: indexPath) as! CollectionViewSingleHeader

        if let sectionKind = Section(rawValue: Section.allCases[indexPath.section].rawValue) {
            switch sectionKind {
            case .category:
                header.configureTitle(title: S.ourMenu)
                header.configureButton(title: S.menuButton, isVisible: true)
                header.button.addTarget(self, action: #selector(goToMenuTapped), for: .touchUpInside)
            case .popular:
                header.configureTitle(title: S.popular)
                header.button.isHidden = true
            }
        }
        return header
    }
}
